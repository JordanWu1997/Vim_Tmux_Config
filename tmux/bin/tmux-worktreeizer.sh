#!/usr/bin/env bash

# Auto-magical tmux session creation for a chosen git worktree.
#
# Usage:
#   $ tmux-worktreeizer.sh              # worktree as its own session (default)
#   $ tmux-worktreeizer.sh --window     # worktree as a window in this session
#
#   --session suits long-lived work: the worktree gets its own set of windows
#   (editor, server, tests) and `tmux-unworktreeizer.sh` can tear the whole
#   thing down by killing one session.
#
#   --window suits a quick look at a branch: no session sprawl, and prefix+h/l
#   flips between worktrees. The window is tagged with @worktree_path so the
#   teardown script can still close it when the worktree goes away.
#
# Description:
#
#   For ease of use, symlink this script to a directory in your PATH, e.g.:
#
#   $ ln -s ~/path/to/tmux-worktreeizer.sh ~/.local/bin/tmux-worktreeizer.sh
#
#   Then bind it in tmux (see tmux.conf, `bind W`). It is designed to be run
#   from `display-popup -E`, so it must be started with the *pane's* cwd:
#
#     bind W display-popup -w 80% -h 80% -d "#{pane_current_path}" \
#         -E "tmux-worktreeizer.sh"
#
#   Do NOT use `run-shell "tmux neww ..."` -- `new-window` without `-c` starts
#   in the session's original directory, not the pane's, so the script would
#   look for a repo in the wrong place.
#
# Effects:
#   - prompted with fzf menu to select the target branch
#   - a new tmux session will be created with the truncated branch name as the
#     name
#
# Example:
#
#   Say we are currently in the repo root at ~/my-repo and we are on `main`
#   branch.
#
#   $ tmux-worktreeizer.sh
#
#   You will then be prompted with fzf to select the branch you want to work
#   on. Markers show what already exists locally:
#
#   ```
#   ● main               <- a worktree already exists, will just switch to it
#   ○ feature/foo        <- local branch, worktree will be created
#   ↑ feature/bar        <- remote-only, local tracking branch will be created
#   worktree branch> ▮
#   ```
#
#   You can then select the branch you want to work on, and a new tmux session
#   is created, named "<calling session>-<short branch>":
#
#     in session "work", pick feature/foo         -> session "work-foo"
#     in session "work", pick release/1.2.3       -> session "work-1_2_3"
#     again from "work-foo", pick feature/bar     -> session "work-bar"
#
#   The base name is remembered in the @worktree_base session option, which is
#   why the third case does not compound into "work-foo-bar". Run outside tmux,
#   the repo directory name is used as the base instead.
#
#   Typing a name that matches nothing and pressing enter creates that branch
#   off the current HEAD, along with its worktree and session.
#
#   Worktrees live inside the repo, under .worktree/, keyed by the *full* branch
#   name. So in ~/code/my-repo:
#
#     feature/foo    ->  ~/code/my-repo/.worktree/feature/foo
#     ENG-1234-thing ->  ~/code/my-repo/.worktree/ENG-1234-thing
#
#   .worktree/ is added to .git/info/exclude automatically, so the worktrees
#   never show up as untracked files. info/exclude is local to your clone, so
#   this does not touch the repo's tracked .gitignore.
#
#   If the worktree already exists, it is reused (idempotent switching).
#
# Environment:
#   WORKTREEIZER_FETCH=0   skip the background `git fetch --prune`
#   WORKTREE_DIR=<name>    directory under the repo root (default: .worktree)

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
    tmux display-message -d 4000 "worktreeizer: $*" 2>/dev/null || true
  fi

  if [[ -t 0 ]]; then
    printf '\nPress any key to close...' >&2
    read -rsn1 || true
  fi

  exit 1
}

# Resolve to a canonical path, falling back to the input when the directory is
# gone (so comparisons against dead tmux session paths still behave).
abspath() (
  if cd "$1" 2>/dev/null; then
    pwd -P
  else
    printf '%s\n' "$1"
  fi
)

# tmux rewrites "." and ":" in session names to "_". Do the same up front so
# that has-session/switch-client lookups match what tmux actually stored --
# otherwise a branch like release/1.2.3 can never be found again.
tmux_safe_name() {
  printf '%s' "$1" | tr '.:' '__'
}

for cmd in git fzf tmux awk; do
  command -v "$cmd" >/dev/null 2>&1 || die "required command not found: $cmd"
done

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------

TARGET_KIND=session

while [[ $# -gt 0 ]]; do
  case "$1" in
    -w | --window) TARGET_KIND=window ;;
    -s | --session) TARGET_KIND=session ;;
    -h | --help)
      printf 'usage: %s [--session|--window]\n\n' "${0##*/}"
      printf '  --session  (default) open the worktree as its own tmux session\n'
      printf '  --window   open the worktree as a window in the current session\n'
      exit 0
      ;;
    *) die "unknown option: $1 (try --help)" ;;
  esac
  shift
done

if [[ "$TARGET_KIND" == window && -z ${TMUX:-} ]]; then
  die "--window must run inside tmux; there is no current session to add to"
fi

# ---------------------------------------------------------------------------
# Locate the repo
# ---------------------------------------------------------------------------

# --git-common-dir is shared across worktrees, and works in bare repos too, so
# this single call both validates "are we in a repo" and gives us a stable base.
COMMON_GIT_DIR="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" ||
  die "not inside a git repository (cwd: $PWD)"

if [[ "$(basename "$COMMON_GIT_DIR")" == ".git" ]]; then
  REPO_ROOT="$(cd "$COMMON_GIT_DIR/.." && pwd -P)"
  REPO_NAME="$(basename "$REPO_ROOT")"
else
  # Bare repo layout: /path/my-repo.git
  REPO_ROOT="$COMMON_GIT_DIR"
  REPO_NAME="$(basename "${COMMON_GIT_DIR%.git}")"
fi

# Drop registrations whose directories no longer exist. Without this, a worktree
# you deleted with `rm -rf` stays registered as "prunable", the lookup below
# happily returns its dead path, and tmux silently opens a session rooted at a
# directory that isn't there. Note that `fetch --prune` does NOT do this: it
# only prunes remote-tracking refs.
git worktree prune

# Refresh remotes in the background so fzf opens instantly. We wait on it before
# touching any refs (see below).
fetch_pid=""
if [[ "${WORKTREEIZER_FETCH:-1}" != 0 ]]; then
  git fetch --quiet --prune >/dev/null 2>&1 &
  fetch_pid=$!
fi

# ---------------------------------------------------------------------------
# Map branch -> worktree path
# ---------------------------------------------------------------------------

# `git worktree list --porcelain` emits repeated blocks like:
#   worktree <path>
#   HEAD <sha>
#   branch refs/heads/<name>
#
# Slice by offset rather than splitting on whitespace -- $2 would truncate any
# path containing a space and silently resolve to a *different* worktree.
#   "worktree "    is  9 chars -> path starts at 10
#   "branch refs/heads/" is 18 chars -> branch starts at 19
worktree_map="$(
  git worktree list --porcelain | awk '
    /^worktree /            { wt = substr($0, 10); next }
    /^branch refs\/heads\// { printf "%s\t%s\n", substr($0, 19), wt }
  '
)"

worktree_for_branch() {
  [[ -n "$worktree_map" ]] || return 0
  printf '%s\n' "$worktree_map" |
    awk -F'\t' -v want="$1" '$1 == want { print $2; exit }'
}

# ---------------------------------------------------------------------------
# Build the branch list
# ---------------------------------------------------------------------------

local_branches="$(git for-each-ref --format='%(refname:short)' refs/heads)"

remote_only="$(
  comm -23 \
    <(git for-each-ref --format='%(refname:short)' refs/remotes |
      sed 's|^[^/]*/||' |
      grep -v '^HEAD$' |
      sort -u) \
    <(printf '%s\n' "$local_branches" | sort -u)
)"

# Markers double as fzf field 1, which keeps `--nth=2..` and `{2}` aligned for
# every row (a blank marker would collapse and shift the fields).
#   ● worktree already checked out    ○ local branch    ↑ remote-only
branch_list="$(
  {
    awk -F'\t' '
      NR == FNR { if (NF == 2) has[$1] = 1; next }
      $0 != ""  { printf "%s %s\n", (has[$0] ? "●" : "○"), $0 }
    ' <(printf '%s\n' "$worktree_map") <(printf '%s\n' "$local_branches")

    if [[ -n "$remote_only" ]]; then
      printf '%s\n' "$remote_only" | sed 's/^/↑ /'
    fi
  }
)"

[[ -n "$branch_list" ]] || die "no branches found in $REPO_NAME"

# --print-query puts whatever was typed on line 1 and the picked row (if any) on
# line 2, which is what lets an unmatched query become a brand new branch.
# fzf exits 1 when nothing matched -- that is a valid outcome here, not a
# failure -- so only a real abort (130 = ESC/ctrl-c) or error bails out.
set +e
result="$(
  printf '%s\n' "$branch_list" | fzf \
    --prompt='worktree branch> ' \
    --header='● worktree  ○ local  ↑ remote   enter on an unmatched name creates it' \
    --print-query \
    --nth=2.. \
    --reverse \
    --preview-window='down:60%:wrap' \
    --bind='alt-p:toggle-preview' \
    --preview='git log --oneline --decorate --color=always -25 {2} -- 2>/dev/null ||
               git log --oneline --decorate --color=always -25 origin/{2} -- 2>/dev/null ||
               echo "(no commits found for {2})"'
)"
fzf_status=$?
set -e

case $fzf_status in
  0 | 1) ;;
  *) exit 0 ;;
esac

query="$(printf '%s\n' "$result" | sed -n '1p')"
picked="$(printf '%s\n' "$result" | sed -n '2p')"

create_new=0

if [[ -n "$picked" ]]; then
  # Every row is "<marker> <branch>", so the branch starts at offset 2.
  branch="${picked:2}"
elif [[ -n "$query" ]]; then
  branch="$query"
  # Nothing matched, so treat the query as a new branch -- unless it happens to
  # name an existing ref exactly.
  if ! git show-ref --verify --quiet "refs/heads/$branch"; then
    create_new=1
    git check-ref-format --branch "$branch" >/dev/null 2>&1 ||
      die "not a valid branch name: $branch"
  fi
else
  exit 0
fi

[[ -n "$branch" ]] || exit 0

# ---------------------------------------------------------------------------
# Derive the worktree / session name
# ---------------------------------------------------------------------------

base="${branch##*/}"

# Grab a leading ticket like ENG-1234 / eng-1234
ticket="$(printf '%s\n' "$base" | grep -oE '^[[:alpha:]]+-[0-9]+' || true)"

if [[ -n "$ticket" ]]; then
  # Remove "<ticket>-" prefix
  rest="${base#"$ticket"-}"

  # Take first 3 dash-separated words
  short_rest="$(printf '%s\n' "$rest" | cut -d- -f1-3)"

  WORKTREE_NAME="${ticket}-${short_rest}"
else
  # No ticket: just take first 4 words of base (or cap length)
  WORKTREE_NAME="$(printf '%s\n' "$base" | cut -d- -f1-4)"
fi

WORKTREE_NAME="$(printf '%s\n' "$WORKTREE_NAME" | tr '[:upper:]' '[:lower:]')"
WORKTREE_NAME="${WORKTREE_NAME:0:40}"

# Store worktrees inside the repo, keyed by the full branch name so that
# feature/foo and feature/bar nest naturally and can never collide.
WORKTREES_DIR="$REPO_ROOT/${WORKTREE_DIR:-.worktree}"

# ---------------------------------------------------------------------------
# Find or create the worktree
# ---------------------------------------------------------------------------

existing_path="$(worktree_for_branch "$branch")"

if [[ -n "$existing_path" ]]; then
  WORKTREE_PATH="$existing_path"
else
  # Wait for the background fetch before mutating refs, both to avoid racing on
  # the ref locks and so a remote-only branch actually resolves.
  if [[ -n "$fetch_pid" ]]; then
    wait "$fetch_pid" 2>/dev/null || true
    fetch_pid=""
  fi

  # The full branch name keys the path, so two branches can never land on the
  # same directory the way a truncated name could.
  WORKTREE_PATH="$WORKTREES_DIR/$branch"

  [[ -e "$WORKTREE_PATH" ]] &&
    die "$WORKTREE_PATH exists but is not a worktree for $branch"

  # Keep the worktrees out of `git status` in the main worktree. info/exclude
  # lives in the common git dir, so this is per-clone and never touches the
  # repo's tracked .gitignore.
  exclude_file="$COMMON_GIT_DIR/info/exclude"
  exclude_rule="/${WORKTREE_DIR:-.worktree}/"
  mkdir -p "$(dirname "$exclude_file")"
  if ! grep -qxF -- "$exclude_rule" "$exclude_file" 2>/dev/null; then
    printf '%s\n' "$exclude_rule" >> "$exclude_file"
  fi

  # A nested branch name like feature/foo needs its parent directory first.
  mkdir -p "$(dirname "$WORKTREE_PATH")"

  if [[ $create_new == 1 ]]; then
    # Brand new branch, forked from wherever HEAD currently is.
    OUTPUT="$(git worktree add -b "$branch" "$WORKTREE_PATH" 2>&1)" ||
      die "unable to create branch $branch"$'\n\n'"$OUTPUT"
  else
    # For a remote-only branch git DWIMs this into
    # `--track -b <branch> <path> <remote>/<branch>` when exactly one remote has
    # it, and errors clearly when the choice is ambiguous.
    OUTPUT="$(git worktree add "$WORKTREE_PATH" "$branch" 2>&1)" ||
      die "unable to create worktree for $branch"$'\n\n'"$OUTPUT"
  fi
fi

# tmux will happily create a session rooted at a path that does not exist, which
# is exactly how a stale worktree turns into a confusing broken session. Refuse.
[[ -d "$WORKTREE_PATH" ]] ||
  die "worktree path does not exist: $WORKTREE_PATH"

target_real="$(abspath "$WORKTREE_PATH")"

# ---------------------------------------------------------------------------
# --window: open the worktree as a window in the current session
# ---------------------------------------------------------------------------

if [[ "$TARGET_KIND" == window ]]; then
  current_session="$(tmux display-message -p '#{session_name}' 2>/dev/null || true)"
  [[ -n "$current_session" ]] || die "could not determine the current tmux session"

  # Windows are tracked by an @worktree_path tag rather than by the pane's cwd:
  # the user will cd around inside the window, and the tag still has to be
  # correct later when the teardown script looks for windows to close.
  existing_window=""
  while IFS=$'\t' read -r wid wsess wpath; do
    [[ -n "$wid" && -n "$wpath" ]] || continue
    [[ "$wsess" == "$current_session" ]] || continue
    if [[ "$wpath" == "$target_real" ]]; then
      existing_window="$wid"
      break
    fi
  done < <(
    tmux list-windows -a \
      -F "#{window_id}$(printf '\t')#{session_name}$(printf '\t')#{@worktree_path}" \
      2>/dev/null || true
  )

  if [[ -z "$existing_window" ]]; then
    existing_window="$(
      tmux new-window -t "=$current_session" -c "$WORKTREE_PATH" \
        -n "$WORKTREE_NAME" -P -F '#{window_id}'
    )" || die "could not create a window for $branch"

    # NB: set-option rejects the "=name" exact-match form; a window id (@N) is
    # unambiguous anyway.
    tmux set-option -w -t "$existing_window" @worktree_path "$target_real" 2>/dev/null || true
  fi

  tmux select-window -t "$existing_window" ||
    die "could not select the window for $branch"

  exit 0
fi

# ---------------------------------------------------------------------------
# Find or create the tmux session
# ---------------------------------------------------------------------------

# Reuse any session already rooted at this worktree, whatever it is called.
# This handles e.g. main being checked out at REPO_ROOT under a session named
# after the repo rather than the branch.
existing_session=""

while IFS=$'\t' read -r sname spath; do
  [[ -n "$sname" ]] || continue
  if [[ "$(abspath "$spath")" == "$target_real" ]]; then
    existing_session="$sname"
    break
  fi
done < <(tmux list-sessions -F "#{session_name}$(printf '\t')#{session_path}" 2>/dev/null || true)

# New sessions are named "<base>-<short branch>", where <base> is the session we
# were called from, so every worktree of one checkout sorts together in the
# session list. @worktree_base carries the *original* base forward, so
# worktreeizing again from "work-foo" gives "work-bar", not "work-foo-bar".
session_base=""
if [[ -n ${TMUX:-} ]]; then
  session_base="$(tmux display-message -p '#{@worktree_base}' 2>/dev/null || true)"
  [[ -n "$session_base" ]] ||
    session_base="$(tmux display-message -p '#{session_name}' 2>/dev/null || true)"
fi

# Launched outside tmux there is no session to inherit from, so key off the repo.
session_base="${session_base:-$REPO_NAME}"

if [[ -n "$existing_session" ]]; then
  SESSION_NAME="$existing_session"
else
  SESSION_NAME="$(tmux_safe_name "${session_base}-${WORKTREE_NAME}")"

  # Worktree paths are unique, but the *session* name is still truncated, so
  # feature/fix-login-bug-in-safari and .../-chrome both want "fix-login-bug-in".
  # No session at our path matched above, so a name clash here is a different
  # worktree -- give ours a stable suffix instead of hijacking theirs.
  if tmux has-session -t "=$SESSION_NAME" 2>/dev/null; then
    suffix="$(printf '%s' "$branch" | cksum | cut -d' ' -f1)"
    SESSION_NAME="$(tmux_safe_name "${session_base}-${WORKTREE_NAME}-${suffix:0:6}")"
  fi
fi

# "=name" forces an exact match. Without it tmux falls back to prefix/fuzzy
# matching and can land you on the wrong session (feat-login vs feat-login-v2).
TARGET="=$SESSION_NAME"

if ! tmux has-session -t "$TARGET" 2>/dev/null; then
  # This also starts the server when none is running.
  tmux new-session -ds "$SESSION_NAME" -c "$WORKTREE_PATH"

  # Remember the base so sessions spawned from this one do not compound names.
  # NB: set-option rejects the "=name" exact-match form -- pass the bare name
  # (tmux resolves an exact match first anyway).
  tmux set-option -t "$SESSION_NAME" @worktree_base "$session_base" 2>/dev/null || true
fi

if [[ -n ${TMUX:-} ]]; then
  tmux switch-client -t "$TARGET" || die "could not switch to session $SESSION_NAME"
else
  tmux attach-session -t "$TARGET" || die "could not attach to session $SESSION_NAME"
fi
