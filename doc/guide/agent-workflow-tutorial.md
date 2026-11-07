# Agent Workflow Tutorial: Vim + tmux + Claude Code

Hands-on walkthrough of working with a coding agent next to Vim, using the configuration in `Vim_Tmux_Config` (Neovim 0.9+ / Vim 9.1, tmux ≥ 3.2) · 2026-11-05. Companion to `vim-tmux-user-guide`, which lists every key.

## Contents

1.  The idea in one picture
2.  Before you start
3.  Set up the workspace
4.  Example 1: the agent fixes a failing test
5.  Example 2: hand lint errors to the agent
6.  Example 3: follow what the agent points at
7.  Example 4: run code while the agent works
8.  Example 5: several agents in parallel (worktrees)
9.  Writing prompts in Vim
10. Knowing when the agent is done
11. Reboots and recovery
12. Cheat sheet
13. Troubleshooting

## 1. The idea in one picture

You stay in Vim. The agent works in a tmux pane next to it, and a plain shell pane runs tests and scripts. Vim talks to both panes: it **sends** references, diagnostics and text to the agent, **runs** commands in the shell, and **reads** output back into the quickfix list. When the agent edits files, Vim reloads them and gitgutter shows exactly what changed.

    ┌──────────────────────────────┬──────────────────────────────┐
    │ Vim  (pane %1)               │ claude  (pane %2)            │
    │                              │   ← target pane: <leader>x…  │
    │   your code                  │     @refs, diagnostics, text │
    │   ]h [h  review agent hunks  │   → <leader>qt reads it back │
    │                              ├──────────────────────────────┤
    │                              │ bash  (pane %3)              │
    │                              │   ← run pane: tests,         │
    │                              │     <leader>px, <leader>pt…  │
    └──────────────────────────────┴──────────────────────────────┘

| Pane role              | Setting                                                                   | Chosen by                                                                                          | Used by                                                     |
|------------------------|---------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| **Target** (the agent) | `g:vimrc_tmux.target`, default `{last}` = the pane you were in before Vim | `<leader>xt`                                                                                       | `<leader>xr`, `xd`, `xy`, `xx`, `xc`; `<leader>qt` reads it |
| **Run pane** (a shell) | `g:vimrc_tmux.run_target`, default empty                                  | Automatic the first time (first shell pane in Vim's window, or a split it offers), or `<leader>xT` | tests (`<leader>pt*`), run file (`<leader>px`, `pl`)        |

Safety rule: commands for the run pane are typed only into a **shell**. If the pane runs `claude`, `python` or anything else, Vim refuses and tells you which program is there. Text for the target pane is pasted **without Enter** (except `<leader>xx`/`xc`, meant for REPLs), so nothing reaches the agent until you press Enter yourself.

**The loop in short.** Run a test (`<leader>ptn`) → send the agent a reference to the code (`<leader>xr`) and type what you want → watch it (prefix `N`) → review its edits in Vim (`]h`, `<leader>gP`) → rerun the test (`<leader>ptl`) → commit (`<leader>gs`). Sections 3 and 4 walk through each step.

### Words used in this tutorial

| Word          | Meaning                                                                                                           |
|---------------|-------------------------------------------------------------------------------------------------------------------|
| `<leader>xr`  | Press Space, then x, then r (in Vim's normal mode)                                                                |
| prefix `N`    | Press Ctrl+b (or Ctrl+a), let go, then `N` (Shift+n)                                                              |
| Pane, pane id | A tmux pane is one terminal area in a window. Each has an id like `%2` that stays the same while the pane exists. |
| Target pane   | The pane Vim sends text and references to: normally the agent                                                     |
| Run pane      | The shell pane where Vim runs tests and scripts                                                                   |
| Quickfix list | A list of file:line positions you jump through with `<leader>qj` / `qk`                                           |
| Hunk          | One block of lines that changed compared with git                                                                 |
| `@file:L12`   | Claude Code's way to point at a file and line; Vim writes these for you                                           |
| Worktree      | A second checkout of the same git repository in another folder, on its own branch                                 |

## 2. Before you start

New to this setup? Install it with **Getting Started** (`getting-started.html`) and try section 1 of the **User Guide** first.

- tmux uses this repo's `tmux.conf` (it enables `focus-events`, needed for auto-reload, and extended keys, needed for Shift+Enter in Claude Code).
- Vim uses `vim/vimrc`; plugins are installed (`:PlugInstall`).
- The project is a git repository (references, project root, sessions and gitgutter rely on it). A `.venv` at its root is used automatically for tests and runs.
- Claude Code is installed (see Anthropic's Claude Code setup page) and `claude` runs in a terminal. The first run asks you to log in. Any terminal agent works the same way; only the examples say `claude`.
- Optional: `notify-send` for desktop notifications (section 10).

## 3. Set up the workspace

1.  Start a session in the repo and open Vim:

        cd ~/code/shop && tmux new -s shop
        nvim                      # in the git root: Session.vim tracking starts (section 11)

    (`shop` is an example project; use your own git repository. `-s shop` names the tmux session.)

2.  Split a pane to the right (prefix `%`) and start the agent there: `claude`.

3.  Split the agent pane downwards (prefix `"`). This shell is your run pane. Run `source .venv/bin/activate` here if you like; Vim doesn't need it, because it prefixes commands with the project venv.

4.  Go back to Vim with Ctrl+h (Ctrl+h/j/k/l move between Vim splits and tmux panes alike).

5.  Pin the agent as the target, so it doesn't change when you visit other panes. Press `<leader>xt`; Vim lists the panes:

        %1  1.0  nvim    /home/me/code/shop
        %2  1.1  claude  /home/me/code/shop
        %3  1.2  bash    /home/me/code/shop
        tmux target pane: {last}

    Replace `{last}` with `%2` and press Enter. (Pane ids like `%2` never change while the pane lives; `{last}` follows you around.)

6.  Nothing to do for the run pane: the first test or run finds `%3` by itself and prints `Run pane: %3 (change with <leader>xT)`. If there is no shell pane, Vim asks *"Split one below vim?"* and creates it.

7.  Optional: `<leader>Le` starts the language server (completion, diagnostics, go-to-definition). If it gets noisy while the agent rewrites code, switch features off one at a time with `<leader>Lt…` (section 5).

## 4. Example 1: the agent fixes a failing test

The project has `shop/cart.py` and `tests/test_cart.py`. A discount test fails.

### 4.1 Reproduce

1.  Open the test file (`<leader>fgf`, type `test_cart`), put the cursor in `test_discount_is_applied` (type `/test_discount` and Enter) and press `<leader>ptn`. The run pane shows:

        $ cd '/home/me/code/shop' && env VIRTUAL_ENV='/home/me/code/shop/.venv' PATH='/home/me/code/shop/.venv/bin':"$PATH" pytest tests/test_cart.py::test_discount_is_applied
            def test_discount_is_applied():
        >       assert total([Item(100)], discount=0.1) == 90
        E       assert 100 == 90
        tests/test_cart.py:14: AssertionError

### 4.2 Hand it over

1.  Still in the test, select the test function (`V` and move, or `vap`) and press `<leader>xr`. The agent's prompt now contains `@tests/test_cart.py:L12-L15 ` (no Enter yet; the path starts at the git root, where the agent runs, and a path with spaces is sent quoted: `@"my dir/a.py":L3`).

2.  Open `shop/cart.py` (`<leader>fgf`, type `cart`), find `total()` with `/def total` Enter, and press `<leader>xr`: `@shop/cart.py:L30 ` is appended.

3.  Move to the agent pane (Ctrl+l) and finish the prompt:

        @tests/test_cart.py:L12-L15 @shop/cart.py:L30 this test fails with
        "assert 100 == 90": the discount is ignored. Fix total(), not the test.

    Press Enter. (Shift+Enter inserts a newline in Claude Code.)

4.  Press prefix `N` in the agent pane to watch it: its border shows `[W]`, and after 15 s without screen changes `[Q]`, a tmux message, a desktop notification "Pane screen quiet" and, if you're in another window, a magenta `!` on its tab (section 10). Go back to Vim and keep working.

### 4.3 Review what the agent changed

1.  When the agent edits `shop/cart.py`, Vim reloads it as soon as you return to Vim, enter the buffer, or stay idle briefly: *"File changed on disk, reloaded: shop/cart.py"*. If you had unsaved edits in that file, Vim asks instead of overwriting them.

2.  In the changed file, `]h` / `[h` jump between changed hunks (gitgutter switches on for that buffer). On a hunk:
    - `<leader>gP` previews the old version;
    - `<leader>gr` undoes the hunk (reject that part);
    - `<leader>ga` stages it (accept that part).

3.  For a bigger change, `<leader>gv` shows the file side by side with git's version; `do`/`dp` take or drop a hunk, `]c`/`[c` move.

4.  To review every file the agent touched, run in the shell pane:

        ~/Desktop/Vim_Tmux_Config/vim/bin/git_diff_vim.sh      # tracked files with changes
        ~/Desktop/Vim_Tmux_Config/vim/bin/git_diff_vim.sh -u   # also new (untracked) files
        ~/Desktop/Vim_Tmux_Config/vim/bin/git_diff_vim.sh -l   # only list them

### 4.4 Verify and commit

1.  `<leader>ptl` reruns the last test, from any file. Green? `<leader>ptf` runs the whole file, `<leader>pts` the suite.
2.  `<leader>gs` opens fugitive's status: `s` stages a file, `=` shows its diff inline, `cc` commits.

Jump to the failure yourself: `<leader>qT` reads the **run** pane's output into the quickfix list (`<leader>qt` reads the agent pane). Python tracebacks and pdb frames are recognised, your project's files come first and library frames are dropped, so `<leader>qj` lands on `tests/test_cart.py:14`.

## 5. Example 2: hand lint errors to the agent

1.  With LSP on (`<leader>Le`), open the file with errors and press `<leader>ee`: diagnostics go to the location list.

2.  Press `<leader>xd`. The agent prompt receives one line per diagnostic, without Enter:

        @shop/cart.py:L3: [W] 'os' imported but unused
        @shop/cart.py:L41: [E] undefined name 'Decimal'

3.  Add your instruction (*"fix these, keep behaviour unchanged"*) in the agent pane and press Enter.

4.  While the agent rewrites the file, signs and inline messages flicker on every reload. Hide them: `<leader>Ltd` (diagnostics off; they're kept, not lost) or only `<leader>Ltv` (inline text off, signs stay). The statusline shows `-lint` while diagnostics are off. Bring them back with the same key; `<leader>Lto` turns everything on again, `<leader>Ltt` shows the state.

5.  Check the result: `<leader>ee` again (empty list = clean), and `]g`/`[g` to step through what's left.

Without LSP, ALE's location list works the same way (`<leader>ee` toggles ALE when LSP is disabled in the config).

## 6. Example 3: follow what the agent points at

The agent answers *"The bug is in shop/cart.py:44 and the same pattern appears in shop/order.py:87 and tests/test_order.py:20"*.

1.  In Vim press `<leader>qt`. It reads the last 300 lines of the agent pane and collects every `file:line`, `@file:L12`, traceback line and pdb frame that points to an existing file: *"3 references from tmux pane %2"*, and the quickfix window opens.
2.  `<leader>qj` / `<leader>qk` (or `]q`/`[q`) visit them one by one; `<leader>qo` browses the list with fzf.
3.  To apply the same edit everywhere: `<leader>qd` starts `:cdo `, e.g. `:cdo s/price \* qty/line_total(price, qty)/ | update`.

## 7. Example 4: run code while the agent works

- **Run the current file:** `<leader>px` saves it and runs `python3 file.py` (or `bash`, or the executable itself) from the git root, with the project venv, in the run pane. `<leader>pl` repeats the last run from any buffer.
- **Half-typed command?** Anything left at the run pane's prompt (say `git sta`) is cleared before the command is pasted, so the two don't merge.
- **Pane busy?** If the run pane is still running something (pytest, a server), Vim doesn't type into it: *"tmux pane %3 runs python, not a shell: not sent"*. Stop it or pick another pane with `<leader>xT`.
- **Scrolled up?** If you were reading old output in copy mode, Vim leaves copy mode before sending, so the command really runs.
- **Different Python:** `:ProjectVenv` shows or activates the project venv inside Vim; `:ProjectVenv ~/venvs/py312` picks another one, which then wins for tests and runs everywhere until `:ProjectVenv!`.
- **Debug:** put `breakpoint()` in the code (`<leader>pb`) and run the test or file; the run pane stops at the pdb prompt, and `<leader>qT` still reads it, so the current frame lands in quickfix. `<leader>pB` starts the debugger on the file in a Vim terminal, with the same venv.
- **Try snippets:** start `ipython` in a pane, make it the target (`<leader>xt`), split the script into `# %%` cells and send them with `<leader>xc`. Tests still go to the shell pane, never into IPython.

## 8. Example 5: several agents in parallel (worktrees)

Give each agent its own checkout, so they never edit the same files.

1.  In any pane of the repo, press prefix Alt+w. An fzf picker lists branches; pick one or type a new name. A git worktree is created and opened in a **new window** of this session (prefix Alt+W opens it as its **own session** instead, for longer work).
2.  In the new window, repeat section 3: `nvim` on the left, `claude` and a shell on the right, `<leader>xt` to pin the agent. Each Vim has its own target and run pane.
3.  The worktree has no `.venv` of its own; tests and `<leader>px` use the main checkout's automatically.
4.  Watch each agent pane with prefix `N`. In the status bar a watched window is underlined, turns yellow with `~` once quiet, and gets a magenta `!` when it needs you. prefix Alt+a jumps to the next window with `!`, in any session, and clears it; prefix `w` lists all windows.
5.  Merge the branch as usual. On conflicts, `git mergetool` opens LOCAL \| BASE \| REMOTE on top and the result below (with the repo's `share/gitconfig`); in Vim, `<leader>gm` starts a 3-way merge of the current file.
6.  Clean up with prefix Alt+X: pick worktrees (Tab for several), and the worktree and its window or session are removed together. It refuses worktrees with uncommitted changes.

## 9. Writing prompts in Vim

- **Long prompts:** in Claude Code, Ctrl+g opens the current prompt in `$EDITOR`. Set it to Neovim once with `export EDITOR=nvim` in `~/.bashrc`. Write with all your keys; `:wq` returns the text to the prompt. The temp file lives outside the project, so it never creates a `Session.vim`.
- **From a buffer:** write the prompt in a scratch buffer or note, select it and press `<leader>xy`: it's pasted into the agent prompt without Enter. `<leader>xy` in normal mode sends the current line.
- **References on the clipboard:** `<leader>yr` copies `@file:L12` (visual: a range) instead of sending it, for pasting somewhere else; `<leader>yp` copies the full path.

## 10. Knowing when the agent is done

- **Pane watch (works for any program):** prefix `N` on the agent pane. After 15 s without visible change: border `[Q]`, status bar `~`, a tmux message and a desktop notification. It detects a quiet screen, not completion, so a long silent build also triggers it. prefix `N` again stops watching.

- **Claude Code hook (exact):** let Claude Code call the notifier when it stops or needs permission. In `~/.claude/settings.json` (create it if missing; if it already exists, add the `"hooks"` key next to what is there instead of replacing the file):

      {
        "hooks": {
          "Stop": [{ "hooks": [{ "type": "command",
            "command": "~/Desktop/Vim_Tmux_Config/tmux/bin/tmux_notify.sh 'Claude Code' 'Finished'" }] }],
          "Notification": [{ "hooks": [{ "type": "command",
            "command": "~/Desktop/Vim_Tmux_Config/tmux/bin/tmux_notify.sh 'Claude Code' 'Needs your input'" }] }]
        }
      }

  The script adds the pane's location (`shop:1.1 claude`) to the message, marks the agent's window with a magenta `!` (unless you're looking at it) and shows a tmux message, so it also works over SSH or without `notify-send`. prefix Alt+a jumps there.

## 11. Reboots and recovery

- **tmux:** tmux-continuum saves the layout every 15 minutes and restores it when tmux starts; prefix Alt+r restores manually (asks first).
- **Vim:** Vim started in the git root inside tmux keeps a `Session.vim` there (splits, tabs, buffers). After a restore, tmux-resurrect starts Vim with it, so your layout is back. Plain `nvim` in that folder also restores it, unless its files are already open in another Vim (say, a second Vim in the same repo); `nvim file`, `cmd | nvim -` and man pages leave it alone. The file is added to the repo's `.git/info/exclude`, so the agent won't commit it. `:Obsess!` stops tracking and deletes it.
- **The agent:** resurrect restarts programs but not their conversation. In the agent pane, `claude --continue` resumes the last conversation of that folder.
- **Pane ids change after a restore:** press `<leader>xt` once to pin the agent again. The run pane is found automatically.

## 12. Cheat sheet

| Goal                                                        | Keys                                            |
|-------------------------------------------------------------|-------------------------------------------------|
| Pin the agent pane / choose the run pane                    | `<leader>xt` / `<leader>xT`                     |
| Send `@file:L12` (visual: range) to the agent               | `<leader>xr`                                    |
| Send diagnostics to the agent                               | `<leader>ee` then `<leader>xd`                  |
| Paste text into the agent prompt (no Enter)                 | `<leader>xy`                                    |
| Agent output / test output → quickfix, then visit           | `<leader>qt` / `<leader>qT`, `<leader>qj/qk`    |
| Test nearest / file / last / suite                          | `<leader>ptn` / `ptf` / `ptl` / `pts`           |
| Run file / run again                                        | `<leader>px` / `<leader>pl`                     |
| Review agent hunks: next/prev, preview, undo, stage         | `]h` `[h`, `<leader>gP`, `gr`, `ga`             |
| Side-by-side diff / git status                              | `<leader>gv` / `<leader>gs`                     |
| Hide diagnostics / inline text while the agent edits        | `<leader>Ltd` / `<leader>Ltv` (all back: `Lto`) |
| Watch a pane for "done" / jump to the window that needs you | prefix `N` / prefix Alt+a                       |
| New worktree: window / session / remove                     | prefix Alt+w / Alt+W / Alt+X                    |
| Move between Vim and panes                                  | Ctrl+h/j/k/l                                    |
| Virtualenv in Vim: show/activate / deactivate               | `<leader>pv` / `<leader>pV`                     |

## 13. Troubleshooting

| Symptom                                           | Cause and fix                                                                                                                                                      |
|---------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| "tmux pane %2 runs claude, not a shell: not sent" | No shell pane in Vim's window and you declined the split, or the run pane you chose is busy. `<leader>xT` picks one.                                               |
| A reference went to the wrong pane                | The target is `{last}` and you visited another pane. Pin it: `<leader>xt` → `%2`.                                                                                  |
| Agent's edit doesn't show in Vim                  | Reload happens on focus, buffer enter or idle; tmux needs `focus-events on` (set by this config). `:checktime` forces it.                                          |
| Vim asks "file changed, load?"                    | You and the agent both changed the file. `L`oad takes the agent's version; `O`K keeps yours (then `:w` overwrites the agent's).                                    |
| `<leader>qt` finds nothing                        | It reads the target (agent) pane's last 300 lines; test output is in the run pane: `<leader>qT`. Only files that exist (relative to the cwd or git root) are kept. |
| "tmux: no pane %9"                                | A run pane you set with `<leader>xT` was closed. Set another one; a run pane Vim picked itself is replaced automatically.                                          |
| Tests use the wrong Python                        | `:ProjectVenv` shows the active one; a venv picked with `:ProjectVenv {dir}` wins until `:ProjectVenv!`.                                                           |
| After a reboot the agent is a fresh conversation  | Expected: run `claude --continue` in its pane.                                                                                                                     |
