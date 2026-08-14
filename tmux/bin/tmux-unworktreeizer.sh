#!/usr/bin/env bash

# Companion teardown for tmux-worktreeizer.sh: remove git worktrees and kill
# the tmux sessions rooted in them, together.
#
# Usage:
#   $ tmux-unworktreeizer.sh
#
# Description:
#
#   Symlink this script to a directory in your PATH, e.g.:
#
#   $ ln -s ~/path/to/tmux-unworktreeizer.sh ~/.local/bin/tmux-unworktreeizer.sh
#
#   Then bind it in tmux (see tmux.conf, `bind M-W`). Like its counterpart it
#   resolves the repo from its cwd, so it must be started with the pane's:
#
#     bind M-W display-popup -w 80% -h 80% -d "#{pane_current_path}" \
#         -E "tmux-unworktreeizer.sh"
#
# Effects:
#   - prompted with fzf (multi-select with TAB) to pick worktrees to remove
#   - each selected worktree is removed with `git worktree remove`
#   - any tmux session rooted at that worktree is killed
#   - stale registrations are pruned
#
#   The main worktree is never listed -- git cannot remove it.
#
# Keys:
#   enter    remove the worktree(s); refuses any with uncommitted changes
#   ctrl-x   remove, and also delete the branch (safe `git branch -d`)
#   ctrl-f   force removal, DISCARDING uncommitted changes
#
# Example:
#
#   ```
#   foo                       feature/foo                    ✗ dirty
#   eng-1234-add-login        ENG-1234-add-login-flow        ↑2 unpushed
#   1.2.3                     release/1.2.3
#   worktree to remove> ▮
#   ```

set -euo pipefail

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# Report an error somewhere the user can actually see it. When we are running
# inside `display-popup -E` the popup is torn down the instant we exit, so also
# push the message to the status line and wait for a keypress.
die() {
  printf 'Error: %s\n' "$*" >&2

  if [[ -n ${TMUX:-} ]]; then
    tmux display-message -d 4000 "unworktreeizer: $*" 2>/dev/null || true
  fi

  if [[ -t 0 ]]; then
    printf '\nPress any key to close...' >&2
    read -rsn1 || true
  fi

  exit 1
}

# Hold the popup open so the user can read the summary before it vanishes.
pause() {
  if [[ -t 0 ]]; then
    printf '\nPress any key to close...' >&2
    read -rsn1 < /dev/tty || true
    printf '\n' >&2
  fi
}

confirm() {
  local reply
  printf '%s [y/N] ' "$1" >&2
  # fzf consumed stdin, and we may be under `-E`; always ask the terminal.
  read -r reply < /dev/tty || return 1
  [[ "$reply" == [yY]* ]]
}

abspath() (
  if cd "$1" 2>/dev/null; then
    pwd -P
  else
    printf '%s\n' "$1"
  fi
)

for cmd in git fzf tmux awk; do
  command -v "$cmd" >/dev/null 2>&1 || die "required command not found: $cmd"
done

# ---------------------------------------------------------------------------
# Locate the repo
# ---------------------------------------------------------------------------

COMMON_GIT_DIR="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" ||
  die "not inside a git repository (cwd: $PWD)"

if [[ "$(basename "$COMMON_GIT_DIR")" == ".git" ]]; then
  REPO_ROOT="$(cd "$COMMON_GIT_DIR/.." && pwd -P)"
else
  REPO_ROOT="$COMMON_GIT_DIR"
fi

# Drop registrations whose directories are already gone, so they neither clutter
# the list nor block a later re-add of the same path.
git worktree prune

# Run every git command from the main worktree. The pane we were launched from
# may well be *inside* the worktree we are about to delete.
cd "$REPO_ROOT"

# ---------------------------------------------------------------------------
# Collect removable worktrees
# ---------------------------------------------------------------------------

# The first block of `git worktree list --porcelain` is always the main
# worktree, which git refuses to remove -- skip it. Slice by offset so paths
# containing spaces survive:
#   "worktree "           is  9 chars -> path starts at 10
#   "branch refs/heads/"  is 18 chars -> branch starts at 19
worktrees="$(
  git worktree list --porcelain | awk '
    function flush() {
      if (wt != "" && !bare && ++n > 1) {
        printf "%s\t%s\n", wt, (br == "" ? "(detached)" : br)
      }
      wt = ""; br = ""; bare = 0
    }
    /^worktree /            { flush(); wt = substr($0, 10); next }
    /^bare$/                { bare = 1; next }
    /^branch refs\/heads\// { br  = substr($0, 19); next }
    END { flush() }
  '
)"

[[ -n "$worktrees" ]] || die "no removable worktrees (only the main worktree exists)"

# Annotate each with anything that would make removal lossy.
rows=""
while IFS=$'\t' read -r wt br; do
  [[ -n "$wt" ]] || continue

  flags=""
  if [[ -d "$wt" ]]; then
    if [[ -n "$(git -C "$wt" status --porcelain 2>/dev/null)" ]]; then
      flags="✗ dirty"
    fi

    if ahead="$(git -C "$wt" rev-list --count '@{upstream}..HEAD' 2>/dev/null)"; then
      if [[ "$ahead" != 0 ]]; then
        flags="${flags:+$flags  }↑${ahead} unpushed"
      fi
    elif [[ "$br" != "(detached)" ]]; then
      # No upstream at all, so nothing here has ever been pushed anywhere.
      flags="${flags:+$flags  }⚠ no upstream"
    fi
  else
    flags="⚠ missing"
  fi

  # Show the path relative to the repo, since with the .worktree/<branch> layout
  # a basename alone is ambiguous (feature/foo and bugfix/foo are both "foo").
  rel="${wt#"$REPO_ROOT"/}"

  display="$(printf '%-34s %-32s %s' "$rel" "$br" "$flags")"
  rows+="${display}"$'\t'"${wt}"$'\t'"${br}"$'\n'
done <<< "$worktrees"

# ---------------------------------------------------------------------------
# Pick
# ---------------------------------------------------------------------------

# Only field 1 is shown; fields 2 and 3 carry the path and branch through fzf
# so nothing has to be re-parsed out of the display text.
result="$(
  printf '%s' "$rows" | fzf \
    --prompt='worktree to remove> ' \
    --header='TAB multi-select   enter: remove   ctrl-x: +delete branch   ctrl-f: force (discards changes)' \
    --multi \
    --reverse \
    --delimiter=$'\t' \
    --with-nth=1 \
    --expect=ctrl-x,ctrl-f \
    --preview-window='down:50%:wrap' \
    --preview='git -C {2} status --short --branch 2>/dev/null || echo "(worktree directory is missing)"'
)" || result=""

[[ -n "$result" ]] || exit 0

# With --expect, line 1 is the key that was pressed ("" for plain enter).
key="$(printf '%s\n' "$result" | head -n1)"
selected="$(printf '%s\n' "$result" | tail -n +2)"

[[ -n "$selected" ]] || exit 0

delete_branch=0
force=0
case "$key" in
  ctrl-x) delete_branch=1 ;;
  ctrl-f) force=1 ;;
esac

# ---------------------------------------------------------------------------
# Confirm
# ---------------------------------------------------------------------------

printf '\nAbout to remove:\n\n' >&2
while IFS=$'\t' read -r _ wt br; do
  [[ -n "$wt" ]] || continue
  printf '  %s\n      branch: %s\n' "$wt" "$br" >&2
done <<< "$selected"

if [[ $force == 1 ]]; then
  printf '\n  ⚠ FORCE: uncommitted changes in these worktrees will be LOST.\n' >&2
fi
if [[ $delete_branch == 1 ]]; then
  printf '\n  The branches above will also be deleted (safe delete; unmerged branches are kept).\n' >&2
fi
printf '\n' >&2

confirm "Proceed?" || { printf 'Aborted.\n' >&2; exit 0; }

# ---------------------------------------------------------------------------
# Work out which sessions are doomed -- BEFORE anything is deleted
# ---------------------------------------------------------------------------

# This has to happen while the directories still exist. tmux stores the raw
# argument it was handed for -c, which is often un-normalized (e.g.
# ".../my-repo/../my-repo-worktrees/foo"), and once the worktree is gone neither
# side can be canonicalized any more, so the paths would never compare equal.
declare -A selected_real=()
while IFS=$'\t' read -r _ wt br; do
  [[ -n "$wt" ]] || continue
  selected_real["$wt"]="$(abspath "$wt")"
done <<< "$selected"

doomed_sessions="" # "<session>\t<worktree path>" per line
survivor=""

while IFS=$'\t' read -r sname spath; do
  [[ -n "$sname" ]] || continue

  sreal="$(abspath "$spath")"
  hit=""
  for wt in "${!selected_real[@]}"; do
    if [[ "$sreal" == "${selected_real[$wt]}" ]]; then
      hit="$wt"
      break
    fi
  done

  if [[ -n "$hit" ]]; then
    doomed_sessions+="${sname}"$'\t'"${hit}"$'\n'
  elif [[ -z "$survivor" ]]; then
    survivor="$sname"
  fi
done < <(tmux list-sessions -F "#{session_name}$(printf '\t')#{session_path}" 2>/dev/null || true)

# ---------------------------------------------------------------------------
# Remove worktrees
# ---------------------------------------------------------------------------

removed_paths=""
failed=0

while IFS=$'\t' read -r _ wt br; do
  [[ -n "$wt" ]] || continue

  remove_args=(worktree remove "$wt")
  [[ $force == 1 ]] && remove_args=(worktree remove --force "$wt")

  if output="$(git "${remove_args[@]}" 2>&1)"; then
    printf '✓ removed %s\n' "$wt" >&2
    removed_paths+="${wt}"$'\n'

    if [[ $delete_branch == 1 && "$br" != "(detached)" ]]; then
      if branch_output="$(git branch -d "$br" 2>&1)"; then
        printf '  ✓ deleted branch %s\n' "$br" >&2
      else
        printf '  ! kept branch %s: %s\n' "$br" "$branch_output" >&2
        printf '    force with: git branch -D %q\n' "$br" >&2
      fi
    fi
  else
    failed=1
    printf '✗ FAILED to remove %s\n    %s\n' "$wt" "$output" >&2
    if [[ $force == 0 ]]; then
      printf '    reselect with ctrl-f to force (this discards uncommitted changes)\n' >&2
    fi
  fi
done <<< "$selected"

git worktree prune

# The .worktree/<branch> layout leaves empty parents behind: removing
# .worktree/feature/foo strips the leaf but not .worktree/feature/.
worktree_root="$REPO_ROOT/${WORKTREE_DIR:-.worktree}"
if [[ -d "$worktree_root" ]]; then
  find "$worktree_root" -type d -empty -delete 2>/dev/null || true
fi

[[ -n "$removed_paths" ]] || { pause; exit 1; }

# ---------------------------------------------------------------------------
# Kill the tmux sessions rooted at the removed worktrees
# ---------------------------------------------------------------------------

# Only kill sessions whose worktree actually went away -- a session whose
# removal failed (dirty, say) must keep its shell.
kill_list=""
while IFS=$'\t' read -r sname wt; do
  [[ -n "$sname" ]] || continue
  if grep -qxF -- "$wt" <<< "$removed_paths"; then
    kill_list+="${sname}"$'\n'
  fi
done <<< "$doomed_sessions"

if [[ -n "$kill_list" ]]; then
  # If the client is sitting in a session we are about to kill, move it first --
  # otherwise killing that session takes this popup down with it.
  current_session=""
  [[ -n ${TMUX:-} ]] &&
    current_session="$(tmux display-message -p '#{session_name}' 2>/dev/null || true)"

  if [[ -n "$current_session" ]] && grep -qxF "$current_session" <<< "$kill_list"; then
    if [[ -n "$survivor" ]]; then
      tmux switch-client -t "=$survivor" 2>/dev/null || true
    else
      printf '\n! %s was the only session left; the tmux server will exit.\n' \
        "$current_session" >&2
      pause
    fi
  fi

  while IFS= read -r s; do
    [[ -n "$s" ]] || continue
    tmux kill-session -t "=$s" 2>/dev/null &&
      printf '✓ killed session %s\n' "$s" >&2
  done <<< "$kill_list"
fi

# ---------------------------------------------------------------------------
# Close worktree windows opened with `tmux-worktreeizer.sh --window`
# ---------------------------------------------------------------------------

# Those windows live in someone else's session, so killing sessions above does
# not catch them. They are matched on the @worktree_path tag set at creation
# rather than on the pane's cwd: the directory is gone by now, and the user may
# have cd'd elsewhere inside the window anyway.
removed_real=""
while IFS= read -r p; do
  [[ -n "$p" ]] || continue
  removed_real+="${selected_real[$p]:-$p}"$'\n'
done <<< "$removed_paths"

while IFS=$'\t' read -r wid wname wpath; do
  [[ -n "$wid" && -n "$wpath" ]] || continue
  if grep -qxF -- "$wpath" <<< "$removed_real"; then
    # Closing the last window of a session also ends that session, which is the
    # right outcome here -- nothing is left pointing at a deleted directory.
    tmux kill-window -t "$wid" 2>/dev/null &&
      printf '✓ closed window %s\n' "${wname:-$wid}" >&2
  fi
done < <(
  tmux list-windows -a \
    -F "#{window_id}$(printf '\t')#{window_name}$(printf '\t')#{@worktree_path}" \
    2>/dev/null || true
)

[[ $failed == 0 ]] || pause
