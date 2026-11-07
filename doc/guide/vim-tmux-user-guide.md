# Vim + tmux User Guide

Task-based guide to the configuration in `Vim_Tmux_Config` (branch `main`) for Neovim 0.9+ and Vim 9.1 · updated 2026-11-07. Every key in this guide was checked against the live configuration. The appendix lists all 405 normal-mode leader keys.

## Contents

1.  Start here: concepts and your first day
2.  Daily layout with tmux
3.  Python development
4.  Working with coding agents
5.  Markdown note-taking
6.  Searching and navigating
7.  Git workflow
8.  Writing LaTeX and other files
9.  AI, sessions, terminal and utilities
10. Customizing the configuration
11. Troubleshooting
12. Appendix: every leader key

## 1. Start here: concepts and your first day

Not installed yet? Follow **Getting Started** (`getting-started.html`) first: install in 5 steps and the keys for your first 15 minutes. New to Vim or tmux? Read this section, then follow "Your first day" below. The rest of the guide is organised by task, so you can jump to what you need. For working with a coding agent, read the companion **Agent Workflow Tutorial** (`agent-workflow-tutorial.html`).

### 1.1 How keys are written

| In this guide | Means                                                                  |
|---------------|------------------------------------------------------------------------|
| `<leader>ffs` | Press Space, then f, f, s, one after another. The leader key is Space. |
| Ctrl+w        | Hold Ctrl and press w at the same time                                 |
| prefix `%`    | tmux: press Ctrl+b (or Ctrl+a), let go, then press `%`                 |
| `:w`          | A command: in normal mode type `:w` and press Enter                    |
| `gd`, `]h`    | Plain keys typed in normal mode, one after another                     |

### 1.2 Words used in this guide

| Word                          | Meaning                                                                                                                                                                                                      |
|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Normal / insert / visual mode | Vim's modes. In **normal** mode keys are commands; in **insert** mode (`i`) they type text; in **visual** mode (`v`, `V`) you select text. Esc returns to normal mode.                                       |
| Buffer                        | A file loaded in Vim. It stays loaded when you switch to another file.                                                                                                                                       |
| Split (window)                | A view inside Vim's screen. Several splits can show the same or different buffers.                                                                                                                           |
| tmux session / window / pane  | A **session** is a set of **windows** (like browser tabs); each window is divided into **panes**, each running its own program (Vim, a shell, an agent). Sessions keep running after you close the terminal. |
| Quickfix / location list      | A list of file positions (search results, test failures, errors) you step through with one key. The location list is the same thing for one split.                                                           |
| LSP                           | Language Server Protocol: a background program (e.g. pylsp) that gives completion, go-to-definition and error checking.                                                                                      |
| Hunk                          | One block of changed lines compared with git                                                                                                                                                                 |
| fzf                           | A fuzzy finder: a pop-up list you narrow down by typing part of a name; Enter picks, Esc cancels.                                                                                                            |
| which-key                     | The menu that appears when you press Space and wait, listing the keys that can follow.                                                                                                                       |
| prefix                        | tmux's command key, Ctrl+b (or Ctrl+a). tmux only reacts to the next key after it.                                                                                                                           |
| Virtualenv (venv)             | A folder (usually `.venv`) holding a project's own Python and packages                                                                                                                                       |

### 1.3 Your first day

1.  Open a terminal, run `tmux`, go to a project (`cd ~/code/project`) and run `nvim`.
2.  Open a file: `<leader>fgf` (files tracked by git; outside a git repo use `<leader>ffs`), type part of its name, Enter. Open a second one the same way; switch between them with `<leader>'`.
3.  Edit: `i` to type, Esc (or `kj`) to stop, `u` to undo, `<leader>ww` to save.
4.  Search the project: `<leader>frg`, type a word, Enter on a result.
5.  Split the tmux window: prefix `%`. A shell opens on the right; Ctrl+h / Ctrl+l move between Vim and the shell.
6.  In a Python file, press `<leader>Le` (code intelligence; the first time, install the server first: section 3.1). The statusline now shows `LSP`. Try `K` on a function name (documentation) and `gd` (go to its definition; Ctrl+o jumps back).
7.  Quit with `<leader>qq` (closes the current split; repeat for each). With unsaved changes Vim refuses: save first with `<leader>ww`, or discard with `:q!`. Leave tmux running with prefix `d`; come back later with `tmux attach`.

Lost? Press Space and wait for the which-key menu, or search all keys with `<leader>fmp`. Section 11 lists common problems.

### 1.4 Good to know

- **Leader is Space.** Press it and wait a moment, and the **which-key** menu lists the groups. Each group is one letter: `b` buffers, `f` fzf, `g` git, `p` python/tests, `w` write/wiki, `x` tmux send/run pane, `L` LSP, `D` debugger, `T` toggles, and so on. Below, `<leader>ffs` means Space f f s.
- **Things that are off until you ask** (to keep startup light):
  - Language servers start with `<leader>Le`. Once on, each LSP feature (lint, completion, doc preview, ...) can be switched off and on again separately (section 3.4).
  - Git tools load on your first Git key or `:Git`.
  - Tests, the debugger, tagbar, the undo tree and others load on first use.
- **Toggles live in one group:** `<leader>T` + a letter switches an option or feature and prints its new state, e.g. `Tw` wrap, `Ts` spell, `Tn`/`Tr` line numbers, `Tf` format on save. The older keys (`<leader>wp`, `F5`, ...) still work.
- **Leaving insert mode:** Esc, Ctrl+\[ or `kj`. In normal mode, Esc also clears the search highlight.
- **Finding keys:**
  - Fuzzy-search all mappings with `<leader>fmp` and all commands with `<leader>fcd`.
  - Vim help tags: `<leader>fht`.
  - Where a key is defined: `:verbose nmap <key>`.
- **Files reopen where you left them:** the cursor goes back to its last position (not in commit messages or diffs).
- **The same file works in Vim and Neovim** (`~/.vimrc` or `~/.config/nvim/init.vim`).

## 2. Daily layout with tmux

A typical window has Vim on the left, and a shell (tests, REPL) plus a coding agent on the right. The tmux prefix is Ctrl+b or Ctrl+a, written **prefix** below.

| Goal                                             | Keys                                                                          | Notes                                                                                                                                                                                                                                                                                                    |
|--------------------------------------------------|-------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Move between Vim splits and tmux panes           | Ctrl+h/j/k/l                                                                  | One movement model across both (vim-tmux-navigator). Inside a zoomed pane, it stays in Vim.                                                                                                                                                                                                              |
| Split pane (keeps the current directory)         | prefix `%` / `"`; full width/height: prefix `\|` / `_`                         |                                                                                                                                                                                                                                                                                                          |
| Zoom a pane / a Vim split                        | prefix `z` / `<leader>z` or Ctrl+w z                                          |                                                                                                                                                                                                                                                                                                          |
| Resize Vim split                                 | Alt+h/j/k/l, or `<leader>rw2/rw3/rw4`, `rh2/rh3/rh4` (fraction of the screen) |                                                                                                                                                                                                                                                                                                          |
| Scratch shell or session popup                   | prefix Enter (shell here) / prefix `g` (session `scratch`)                    |                                                                                                                                                                                                                                                                                                          |
| Quick diary note from anywhere                   | prefix Alt+d                                                                  | Opens today's vimwiki diary in a popup                                                                                                                                                                                                                                                                   |
| Git worktree per task or agent                   | prefix Alt+w (new window) / Alt+W (new session) / Alt+X (remove)              | fzf picker for branches and worktrees                                                                                                                                                                                                                                                                    |
| Watch a pane (agent finished?)                   | prefix `N`                                                                    | Marks the pane once it has been quiet for 15 s; its window gets a magenta `!` in the status bar                                                                                                                                                                                                          |
| Jump to the window that needs attention          | prefix Alt+a                                                                  | Cycles through windows marked by the watcher or an agent hook (`tmux_notify.sh`), across sessions; visiting a window clears its mark                                                                                                                                                                     |
| Paste the system clipboard into a pane           | prefix `P`                                                                    | Pastes as typed text (xsel): a multi-line clipboard runs line by line in a shell                                                                                                                                                                                                                         |
| Pane for tests and "run file"                    | `<leader>xT` in Vim                                                           | Usually automatic: if the pane you used last is the agent, the first shell pane in Vim's window becomes the run pane (Vim offers to split one if there is none). Commands go only to a shell, never into an agent or REPL (section 3.5).                                                                 |
| Keep the Vim layout across reboots               | Automatic: start Vim in the git root, inside tmux                             | A `Session.vim` is kept up to date there; tmux-resurrect restores Vim with its splits and tabs (section 9)                                                                                                                                                                                               |
| Restore saved sessions / clear pane history      | prefix Alt+r / Alt+N                                                          | Both ask first                                                                                                                                                                                                                                                                                           |
| Clear scrollback history: this pane / many panes | prefix Ctrl+Shift+l / prefix Ctrl+Alt+l                                       | The first shows the pane's history length and asks y/n. The second opens a menu of all apps or one app (nvim, ranger, ...) with lines and panes per app, then asks. Panes running `htop` or `intel_gpu_top` are also cleared automatically once over 5000 lines (`@history_autoclean_*` in `tmux.conf`). |

## 3. Python development

### 3.1 First-time setup (once per machine)

    pip install ruff pytest ipdb          # formatter/linter, tests, nicer debugger prompt
    # optional formatters used by <leader>nn: shfmt, stylua, prettier, taplo
    # in vim, in any .py file:
    :LspInstallServer pylsp-all          # the server in g:vimrc_tools.python_lsp_servers
    :VimspectorInstall debugpy            # only if you want the graphical debugger

### 3.2 A typical session

1.  Start Vim from the project root (`cd repo && vim`). The working directory stays there (`noautochdir`), so searches and tests are project-wide.
2.  Open files with `<leader>fgf` (git files) or `<leader>ffs`. Use `<leader>'` to switch buffers, or Alt+1..9 for the numbered buffers in the tabline.
3.  Press `<leader>Le` to enable LSP. If the project has `.venv`, `venv` or `env` and no virtualenv is active, it's activated first. The statusline then shows `LSP` / `LSP:pylsp-all` (in windows wider than 90 columns), plus `-lint` / `-cmp` when you switched diagnostics or completion off (`-all` after `<leader>LT`). Windows 71–90 columns wide show just `L+`; 70 columns or less show nothing. Without LSP, `<leader>pv` (`:ProjectVenv`) activates the virtualenv on its own; `<leader>pV` deactivates it.
4.  Write code. A completion menu pops up automatically with LSP symbols, **words from all open buffers** (`[buffer]`) and **file paths** (`[file]`). The first item is pre-selected, so its signature and docs show in a float at once. Enter accepts it; Tab / Shift+Tab or Ctrl+j/k choose another; Ctrl+e closes the menu (then Enter for a new line). After typing `(` or `,` in a call, the **argument hint** shows the signature with the current parameter highlighted. Too busy? `<leader>Ltp` hides the docs float next to the menu, `<leader>Lts` the argument hint (section 3.4).
5.  Format with `<leader>nn` (ruff for Python, or the filetype's default formatter) or `<leader>Lf` (language server), and sort imports with `<leader>npR`. `<leader>Tf` turns format on save on for this buffer.
6.  Run the file with `<leader>px` or the test under the cursor with `<leader>ptn`. Both run in the tmux run pane, in the project virtualenv: the pane you used last if it's a shell; if it's the agent, the first shell pane in Vim's window (Vim offers to split one if there is none); or the pane you chose with `<leader>xT`. A half-typed command at that prompt is cleared first.

### 3.3 Keys while LSP is on (only in LSP buffers)

| Keys                         | Action                                                                                                                                                                              |
|------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `K`                          | Hover documentation in a floating popup at the cursor (closes when you move). Without LSP, `K` in Python runs pydoc.                                                                |
| Alt+e / Alt+y, Alt+G / Alt+g | Scroll the open LSP float (hover, completion docs, argument hint) down/up 4 lines, or jump to its end/start, without leaving your buffer. Works in normal and insert mode.          |
| `gd` / `gy` / `gi`           | Definition / type definition / implementation                                                                                                                                       |
| `gr`                         | References, in the quickfix list                                                                                                                                                    |
| `g/` / `g?`                  | Symbols in this file / in the workspace                                                                                                                                             |
| `[g` / `]g`                  | Previous / next diagnostic                                                                                                                                                          |
| `<leader>ee`                 | All diagnostics → location list; `<leader>ej/ek` to step through                                                                                                                    |
| `<leader>re`                 | Rename symbol                                                                                                                                                                       |
| `<leader>La`                 | Code actions: quick fix, organize imports (also on a visual selection)                                                                                                              |
| `<leader>Lf`                 | Format with the language server: the whole file, or the visual selection                                                                                                            |
| `<leader>Ls` / `LR` / `LM`   | Server status / restart servers / manage servers                                                                                                                                    |
| `<leader>LT`                 | All LSP features off; press again to bring each back as it was. Servers and LSP keys stay                                                                                           |
| `<leader>Lp`                 | Pause LSP: Vim's own keys (`K`, `gd`, `gi`, ...) come back, servers keep running so `<leader>Le` is instant. The statusline shows `LSP paused` (`L-` in windows 71–90 columns wide) |
| `<leader>Ld`                 | Stop LSP: Vim's own keys come back and all servers shut down; `<leader>Le` starts them again                                                                                        |

### 3.4 Switching LSP features on and off

Everything is on when LSP starts. Switch a feature off when it gets in the way and back on when you want it; servers keep running. Your choice also holds after `<leader>Lp` (pause) or `<leader>Ld` (stop) and `<leader>Le`.

| Keys                  | Feature (`:LspFeature` name)           | Off means                                                                   |
|-----------------------|----------------------------------------|-----------------------------------------------------------------------------|
| `<leader>Ltd`         | Diagnostics / lint (`diagnostics`)     | No signs, underlines or `]g`/`[g`. Only hidden: they come back at once.     |
| `<leader>Ltv`         | Virtual text (`virtual_text`)          | No message at the end of the line; signs stay                               |
| `<leader>Ltc`         | Completion (`completion`)              | No LSP pop-up: AutoComplPop takes over; Ctrl+x Ctrl+o still asks the server |
| `<leader>Ltp`         | Completion doc preview (`doc_preview`) | Menu only, no signature/docstring float beside it                           |
| `<leader>Lts`         | Signature help (`signature`)           | No argument hint after `(` / `,`                                            |
| `<leader>Ltr`         | Reference highlight (`references`)     | Other uses of the word under the cursor aren't highlighted                  |
| `<leader>Lta`         | Code-action sign (`code_action`)       | No `A>` sign                                                                |
| `<leader>Lti`         | Inlay hints (`inlay_hints`)            | Vim 9 only; shows `n/a` in Neovim                                           |
| `<leader>Ltt` / `Lto` | Show the state of all / everything on  | `:LspFeature` / `:LspFeature all on`                                        |

As a command: `:LspFeature {name} [on|off|toggle]` (Tab completes). Defaults for the next start: `g:vimrc_lsp` in `vim/local.vim` (section 10).

### 3.5 Testing and running code

| Keys                          | Action                                                                                                                                                                                                                                                                                                                                                                                               |
|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `<leader>ptn` / `ptf` / `pts` | Test nearest / file / whole suite (pytest)                                                                                                                                                                                                                                                                                                                                                           |
| `<leader>ptl`                 | Rerun the last test, even from another file                                                                                                                                                                                                                                                                                                                                                          |
| `<leader>ptv`                 | Go back to the last test file                                                                                                                                                                                                                                                                                                                                                                        |
| `<leader>px` / `<leader>pl`   | Run the current file (python3, bash, or an executable) from the project root / run it again                                                                                                                                                                                                                                                                                                          |
| `<leader>xT`                  | Choose the run pane (empty = the send pane, `<leader>xt`)                                                                                                                                                                                                                                                                                                                                            |
| `<leader>qt`                  | Read the pane's output into the quickfix list: every `file:line`, Python traceback line (`File "x.py", line 42`) and pdb frame. Your project's files come first; library frames (site-packages, stdlib) are dropped when there are project ones. Then `<leader>qj/qk`. `<leader>qT` does the same with the **run** pane: the pane the last test or run went to, also while it waits at a pdb prompt. |

Inside tmux, tests run as `cd <cwd> && env VIRTUAL_ENV=… PATH=…/bin:$PATH <command>` in the run pane. The virtualenv is the one you chose with `:ProjectVenv {dir}`, else the current file's project venv (in a git worktree without one: the main checkout's), else Vim's active one. If the run pane isn't a shell, Vim first looks for a shell pane in its window (or offers to split one below Vim) and remembers it; a run pane you chose yourself that is busy (e.g. still running pytest) is left alone. A pane scrolled up in copy mode is returned to normal first, so the command runs. Outside tmux, tests run in a Vim/Neovim terminal split.

### 3.6 Debugging

- **Quick:** `<leader>pb` inserts `breakpoint()` above the line. `<leader>pB` opens `python3 -m ipdb` (or pdb) on the current file in a terminal split, from the project root with the same virtualenv as tests (ipdb if that venv has it); type the arguments, then Enter.
- **Graphical (vimspector):**
  1.  Run `:VimspectorPythonConfig` once per project (writes `.vimspector.json` at the git root). The program runs with the same virtualenv as tests and `<leader>px`, picked again on every `<leader>Dc` / `Dr`. An older `.vimspector.json` with `"python": "python3"` needs `"$VIMSPECTOR_PYTHON"` there instead.
  2.  `<leader>Db` toggles a breakpoint, `<leader>Dc` starts or continues ("current file" or "pytest current file").
  3.  Step with `<leader>Dn` / `Di` / `Do` (over, into, out).
  4.  `<leader>De` evaluates the word or selection, `<leader>Dr` restarts, `<leader>Dq` quits.

### 3.7 REPL and notebook-style cells

1.  Start `ipython` in the pane next to Vim, then switch back to Vim. That pane is now `{last}`, the default target. (Tests and `<leader>px` refuse to type into it, because it isn't a shell.)
2.  Split the script into cells with lines starting `# %%`.
3.  `<leader>xc` sends the current cell and jumps to the next one. `<leader>xx` sends the line or the visual selection. A second Enter is added automatically after indented blocks.
4.  `<leader>xy` pastes without Enter, so you can edit in the REPL first.

### 3.8 Other Python helpers

- **New files:** a new `.py` file gets the skeleton from `vim/share/templates/skeleton.py`, with a timestamp.
- **Docstrings:** `<leader>nptg` / `nptn` / `nptj` generate them with pyment (google / numpy / javadoc style).
- **Older formatters:** `<leader>npy` (yapf) and `<leader>npi` (isort) are still available.
- **Line length:** `F7` shows a column at 79 characters; `<leader><F7>` highlights characters past it.

## 4. Working with coding agents

| Situation                              | What to do                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| An agent edited a file you have open   | Nothing. It reloads when you return to the Vim pane, enter the buffer, or after half a second idle. If you also changed it, Vim asks first.                                                                                                                                                                                                                                                                                                         |
| Tell the agent where to look           | First pin the agent pane once with `<leader>xt` (enter its id, e.g. `%2`; see the Agent Workflow Tutorial, section 3). Then `<leader>xr` (or select lines first) pastes `@src/app.py:L40-L58` straight into the agent pane, without Enter. Paths start at the git root, where the agent runs. A path with spaces is quoted: `@"my dir/a.py":L12`. `<leader>yr` puts the same reference on the clipboard instead; `<leader>yp` copies the full path. |
| Send text into the agent prompt        | Visual select, `<leader>xy` (pastes into the target pane without pressing Enter)                                                                                                                                                                                                                                                                                                                                                                    |
| Hand the agent the current lint errors | `<leader>ee` (diagnostics → location list), then `<leader>xd`: pastes `@src/app.py:L12: [E] message` lines into the agent pane without Enter, so you can add instructions                                                                                                                                                                                                                                                                           |
| Jump to the files the agent mentioned  | `<leader>qt` (agent pane output → quickfix, tracebacks included), then `<leader>qj/qk`; `<leader>qo` browses the list with fzf                                                                                                                                                                                                                                                                                                                      |
| Agent pane next to a test shell        | Keep `<leader>xt` on the agent (send, capture). Tests and run file pick the shell pane by themselves the first time (or set it with `<leader>xT`). A test command is never typed into the agent's prompt.                                                                                                                                                                                                                                           |
| Review its changes in this file        | `]h` / `[h` jump hunks (gitgutter turns on for this buffer), `<leader>gP` preview, `<leader>ga` stage, `<leader>gr` undo the hunk                                                                                                                                                                                                                                                                                                                   |
| Side-by-side review                    | `<leader>gv`, then `do` / `dp` to take or drop hunks, `]c`/`[c` to move                                                                                                                                                                                                                                                                                                                                                                             |
| Review every changed file              | `vim/bin/git_diff_vim.sh` (add `-u` to include untracked files) opens them all with gitgutter on                                                                                                                                                                                                                                                                                                                                                    |
| Parallel agents                        | One worktree per agent: prefix Alt+w; watch panes with prefix `N`                                                                                                                                                                                                                                                                                                                                                                                   |

Inside a project, local `.exrc`/`.vimrc` files run restricted (`secure`). Neovim also asks you to `:trust` them, so a file an agent drops into the repo can't run commands.

## 5. Markdown note-taking

Every `.md` file is treated as a vimwiki page (filetype `vimwiki`). The wiki root is `~/Documents/KNOWLEDGE_BASE/`, with the diary in `diary/`.

### 5.1 Daily notes

1.  prefix Alt+d in tmux, or `<leader>wdd` in Vim, opens today's diary page.
2.  `<leader>mfI` inserts a note template; Ctrl+g d / t in insert mode inserts the date / date and time.
3.  Ctrl+Up / Down goes to the previous or next diary day; `<leader>wdI` opens the diary index, and `<leader>wdG` regenerates its links.
4.  `<leader>mfj` collects jrnl entries into the page.

### 5.2 Links, tags and navigation

| Keys                                | Action                                                        |
|-------------------------------------|---------------------------------------------------------------|
| `<leader>wI`                        | Wiki index page                                               |
| `<leader><CR>` / `<leader><BS>`     | Follow link (creates the page if missing) / go back           |
| `<leader>mfi`                       | Insert a wiki link by fuzzy search                            |
| `<leader>wb`, `<leader>mfb` / `mfo` | Backlinks (vimwiki) / backlinks and outlinks (markdown-tools) |
| `<leader>w/`, `<leader>mfg`         | Search the wiki / live grep the vault                         |
| `<leader>wt/`, `wtR`, `wtG`         | Search tags, rebuild tags, generate tag links                 |
| `<leader>wT`, `wC`                  | Table of contents, check links                                |
| `<leader>\`                         | Toggle checkbox                                               |
| `<leader>wR` / `wD`                 | Rename / delete the current page (links updated)              |

### 5.3 Writing, preview and export

- **Reading and moving:** notes wrap at words; `j`/`k` move by screen line (`5j` still moves real lines). The cursor stays centred (`scrolloff=999`).
- **Folding by heading:** enable folds with `zi`, then `zc`/`zo`/`zM`/`zR`. The first fold key in a note computes the folds (about half a second for a very long note, once). After that they refresh when you save (`:w`), and `zx` recomputes them.
- **Preview:** `<leader><F4>` toggles a live preview in the browser (`$BROWSER`).
- **Format:** `<leader>nmf` runs mdformat plus your fix-up patch for CJK links, math and checkboxes. The patch decodes only non-ASCII escapes (`%E4%B8%AD` becomes `中`, `%20` stays) and never touches code. If the patch fails, the buffer stays as mdformat left it. One u undoes the whole format, and only that (an edit you made just before is kept).
- **Images:** `<leader>mfp` pastes a clipboard image into `./figures/` and inserts the link; `<leader>mfP` captures the screen first.
- **Export:** `<leader>mfe1` Marp slides, `mfe2`/`mfe3` pandoc HTML, `mfe4` PDF with citations, `mfe5` docx.
- **Writing quality:** spell check is on (`en,cjk`). `<leader>sj/sk` jump to the next/previous error, and `<leader>sag` adds a word to the good list. `<leader>LC` runs LanguageTool (`<leader>Lc` clears it).
- **Focus mode:** `<leader>gy` (Goyo + Limelight).
- **Saving:** `<leader>ww` strips trailing spaces and saves, but keeps two-space hard line breaks.
- **No pop-ups:** there's no automatic completion menu in notes; Ctrl+n/p completes words when you want it.

## 6. Searching and navigating

| Goal                                                     | Keys                                                                                                       |
|----------------------------------------------------------|------------------------------------------------------------------------------------------------------------|
| Files: all / git-tracked / git status / from a directory | `<leader>ffs` / `fgf` / `fgs` / `ffS`                                                                      |
| Text in the project (cwd) / from the git root            | `<leader>frg` (or `<leader>rg`) / `<leader>frr`                                                            |
| Lines in this buffer / in all buffers                    | `<leader>fbl` / `<leader>fgl`                                                                              |
| Buffers, windows, recent files, command/search history   | `<leader>'`, `fws`, `fhs`, `fh:`, `fh/`                                                                    |
| Pick from the quickfix / location list                   | `<leader>fql` / `<leader>fel`; the list follows your pick, so `<leader>qj` continues from there            |
| Delete buffers                                           | `<leader>bD`: select with Tab (Alt+a all, Alt+d none); buffers with unsaved changes are skipped and listed |
| Marks, jumps, changes                                    | `<leader>mk`, `fjl`, `fcl`; `'` / `` ` `` open the mark viewer                                             |
| File tree / reveal current file / symbols                | `F3` / `<leader><F3>` / `F4` (tagbar)                                                                      |
| Jump anywhere on screen                                  | `<leader>j/k/h/l`, `<leader>/` (easymotion)                                                                |
| Replace word under cursor on this line                   | `gs` (part of a word) / `gS` (whole word)                                                                  |
| Replace across files                                     | `<leader>frg`, select results (Tab, Alt+a all) → quickfix, then `<leader>qd` `s/old/new/g \| update`        |
| Fzf window keys                                          | Ctrl+t/s/v open in tab/split/vsplit; Alt+/ toggles preview                                                 |

## 7. Git workflow

Nothing Git-related loads until you press one of these keys. The statusline branch name comes from a cached `git` call, with no plugin loaded.

| Keys                                           | Action                                                                                                                                                                                             |
|------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `<leader>gs`                                   | Status (fugitive): `s`/`u` stage/unstage, `=` inline diff, `cc` commit                                                                                                                             |
| `<leader>gd` / `gD` / `gv`                     | Diff file / all / side by side                                                                                                                                                                     |
| `]h` `[h`, `<leader>gj/gk`                     | Next/previous hunk (count works: `3]h`)                                                                                                                                                            |
| `<leader>ga` / `gr` / `gP`                     | Stage / undo / preview hunk                                                                                                                                                                        |
| `<leader>gA` / `gC`                            | Add current file / commit                                                                                                                                                                          |
| `<leader>gB`, `gc`, `gl`, `fgc`, `fgC`         | Blame, log to quickfix/loclist, fzf commits for buffer/all                                                                                                                                         |
| `<leader>gm`                                   | 3-way merge of a conflicted file                                                                                                                                                                   |
| `git mergetool`                                | LOCAL \| BASE \| REMOTE on top, MERGED below (cursor there). With `share/gitconfig`: conflict markers show the common ancestor (`zdiff3`), resolutions are remembered (`rerere`), no `.orig` files |
| `<leader>gg` / `gb`, `ghs/ghl/ghn`, `gq`, `gF` | Gitgutter on/off (all/buffer), sign/line/number highlights, hunks to quickfix, fold unchanged lines                                                                                                |

## 8. Writing LaTeX and other files

- **LaTeX:** a new `.tex` file gets `template.tex`. Spell check is on. `<leader><F4>` starts a live PDF preview in zathura (pdflatex).
- **Shell:** a new `.sh` file gets `bash_template.sh`.
- **Formatters:** `<leader>ncf` clang-format (C/C++), `<leader>nsf` sqlformat (also on a visual selection).
- **SQL databases:** vim-dadbod / `:DBUI`.
- **HTML:** emmet and auto-closing tags.
- **Hex editing:** `<leader>eho` converts to hex, `<leader>ehf` converts back.

## 9. AI, sessions, terminal and utilities

| Keys / command                      | Action                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|-------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `<leader>oo` / `oe` / `oi` / `or`   | Local AI with Ollama (vim-ai): chat / edit selection / complete / redo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `F12` or `<leader>tm`; `<leader>tt` | Terminal split; tmux session `scratch` inside Vim. `F12` in the terminal returns to normal mode.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `<leader>ut`                        | Undo tree (persistent undo survives restarts)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `<leader>ys`, `"` (in normal mode)  | Yank history; register viewer (peekaboo)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `<C-/>`, `<leader>cc/cu`            | Toggle / add / remove comment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `ys`, `cs`, `ds` + text object      | Add / change / delete surrounding quotes and brackets (e.g. `ysiw"`)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Alt+n, Alt+a                        | Multiple cursors: next match / all matches (`]` `[` next/prev, `q` skip, `Q` remove)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `Session.vim` (automatic)           | Inside tmux, Vim started in a git root keeps `Session.vim` there up to date, so tmux-resurrect can restore its splits and tabs. If one already exists, plain `vim` restores it (unless its files are open in another Vim) and `vim file` leaves it untouched (`:Obsess` replaces it). Starts with a pipe (`cmd \| vim -`), `-q`, `-t`, `-c` or `+cmd` (man pages, `vim +42 file`) are left alone. It's added to the repo's `.git/info/exclude`, so it never shows in `git status`. Not for commit messages, merges, diff mode, files outside the folder or the diary popup. `:Obsess!` stops and deletes it. |
| `<C-s>`, `F10`                      | Save a session file by name; save view (folds and cursor)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `<leader>T` + letter                | Toggles with feedback: `w` wrap, `s` spell, `l` list, `c`/`v` cursor line/column, `e` expandtab, `p` paste, `n`/`r` numbers, `a` autochdir, `f` format on save (python, sh, lua, json, yaml, toml), `k` completion pop-up, `b` rainbow, `g` Goyo, `t` tagbar, `d` ALE                                                                                                                                                                                                                                                                                                                                       |
| `<leader>bu`                        | Revert the buffer to the saved file (asks first if there are unsaved changes)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `<leader>wa` / `wA` / `qq` / `wq`   | Write all / write all and quit / quit / write and quit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `x`                                 | Delete a character without touching the clipboard                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `<leader>cs[g/d/n/s/v/D]`           | Switch colorscheme: gruvbox, dracula, nord, srcery, monokai, default                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

## 10. Customizing the configuration

- **Everything you may change** is at the top of `vim/vimrc`, in five dictionaries:
  - `g:vimrc_features`: feature switches. `1` loads a group of plugins *and* their settings and keys; `0` drops the whole group. Keys: `theme`, `fancy_symbols`, `wal_theme`, `extra`, `coding`, `lsp`, `python_tools`, `gui_apps`, `format_on_save` (0), `auto_session` (1), and the template switches (`python_skeleton`, `tex_template`, `bash_template`, `markdown_template`).
  - `g:vimrc_paths`: directories (`wiki` sets the vimwiki root).
  - `g:vimrc_tools`: browser, Python provider, Python language servers, debugger, LanguageTool jar, Ollama settings, helper scripts.
  - `g:vimrc_tmux`: `target` pane for sending and capturing (`<leader>xt`), `run_target` for tests and run file (`<leader>xT`, empty = `target`), and `capture_lines`.
  - `g:vimrc_lsp`: which LSP features are on when LSP starts (all `1`): `diagnostics`, `virtual_text`, `completion`, `doc_preview`, `signature`, `references`, `code_action`, `inlay_hints`.
- **Per-machine values:** don't edit the tracked file. Create `vim/local.vim` (git-ignored; it is sourced before the defaults) and set only what differs, e.g. `let g:vimrc_features = {'python_tools': 0}` or `let g:vimrc_lsp = {'virtual_text': 0}`. Keys you set override the defaults and everything else stays. A nested dict such as `ollama` must be given in full.
- **Inspect the current values:** `:echo g:vimrc_features` (likewise `g:vimrc_paths`, `g:vimrc_tools`, `g:vimrc_tmux`, `g:vimrc_lsp`); `:LspFeature` shows the current LSP feature state.
- **Lazy-load rules** are in the plugin list (`{'on': [...]}`, `{'for': [...]}`). Keep Git tools and LSP lazy to keep startup around 65–120 ms.
- **Speed:** use `:StartupTime` or `nvim --startuptime log`. See `doc/reports/` for how the config was measured.
- **Options that need a newer version:** set them with `:SetQ` instead of `:set`. Like tmux `set -q`, it quietly skips an option this Vim/Neovim doesn't have, or a value it doesn't accept yet (e.g. `virtualedit=none` needs Neovim 0.7); other errors still show.
- **After changing**: `:source $MYVIMRC` is safe, because autocommands are grouped and cleared, so they don't pile up.

## 11. Troubleshooting

| Symptom                                                                           | Cause and fix                                                                                                                                                                              |
|-----------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| The first `j`/`k` after Esc resizes the window                                    | Read as Alt+j. Fixed with `ttimeoutlen=10`. If it comes back, check `:set ttimeoutlen?` and that tmux has `escape-time 0`.                                                                 |
| Flicker in Neovim inside tmux                                                     | Fixed with `nolazyredraw` (Neovim) and `noshowcmd`. `:set showcmd` shows pending keys temporarily.                                                                                         |
| Typed `k` appears late in insert mode                                             | The `kj` escape mapping waits up to 300 ms for a `j` (by design).                                                                                                                          |
| No completion, `gd` doesn't work                                                  | LSP is off: press `<leader>Le`. Server not installed: `<leader>LI`. Check with `<leader>Ls`. Completion switched off? `:LspFeature` (or `-cmp` in the statusline).                         |
| "tmux pane … runs claude, not a shell: not sent"                                  | No shell pane was found (and you declined the split), or the run pane you chose is busy. Choose a shell pane with `<leader>xT`.                                                            |
| No diagnostics right after `<leader>Lp` or `<leader>Ld` then `<leader>Le`         | The server only resends them after a change: edit or save the file. Also check `-lint` in the statusline.                                                                                  |
| Tests or LSP use the wrong Python                                                 | `:ProjectVenv` shows the active virtualenv; `:ProjectVenv {dir}` switches. Running servers keep the old one: `<leader>LR`.                                                                 |
| `Session.vim` shows up in `git status`                                            | It's excluded per repo when Vim creates it; for files created before that, add `Session.vim` to `~/.config/git/ignore`                                                                     |
| Vim opened with an old layout                                                     | Plain `vim` in a git root restores its `Session.vim`. `:Obsess!` deletes it, or start with a file name.                                                                                    |
| Folds look outdated in a note                                                     | They refresh on save (`:w`); `zx` recomputes them now                                                                                                                                      |
| `]h` does nothing                                                                 | No changes against git in this file, or not a git repo                                                                                                                                     |
| Clipboard doesn't reach the other machine over SSH                                | Needs X forwarding (`ssh -X`) and `xsel`; tmux clipboard sync uses xsel                                                                                                                    |
| Search or tests start in the wrong folder                                         | Vim was started in a subfolder. Use `<leader>frr` (git root), `:cd`, or `<leader>ac` to toggle autochdir.                                                                                  |
| Vim, ranger or htop feel laggy only inside tmux, worse the longer the server runs | Huge scrollback histories: with `alternate-screen off`, full-screen apps redraw into the history. Clear it with prefix Ctrl+Alt+l (section 2); see "Troubleshooting (TMUX)" in the README. |
| Something is slow                                                                 | `:profile start /tmp/p.log \| profile func * \| profile file *`, do the slow action, `:profile stop`                                                                                         |

## 12. Appendix: every leader key (normal mode)

Generated on 2026-11-07 from the live mappings (Neovim 0.9.5, all plugins installed) in a Python buffer with the LSP buffer setup applied and in a markdown note: 405 keys. "buffer: python" means the key exists only in LSP/Python buffers; "buffer: markdown" only in notes. The "Runs" column shows the raw command (long ones are cut).

### \<leader\>a — Args / autochdir (14)

| Keys          | Runs                                                     | Scope  |
|---------------|----------------------------------------------------------|--------|
| `<leader>a$`  | `:last<CR>:args<CR>`                                     | global |
| `<leader>a0`  | `:first<CR>:args<CR>`                                    | global |
| `<leader>aA`  | `:argadd `                                               | global |
| `<leader>aa`  | `:argadd %<CR>:args<CR>`                                 | global |
| `<leader>ab`  | `:abbreviate<CR>`                                        | global |
| `<leader>ac`  | `:set autochdir!<CR>:echo 'autochdir=' . &autochdir<CR>` | global |
| `<leader>aD`  | `:argdelete `                                            | global |
| `<leader>ad`  | `:argdelete %<CR>:args<CR>`                              | global |
| `<leader>ae`  | `:argedit `                                              | global |
| `<leader>agd` | `:argdo `                                                | global |
| `<leader>an`  | `:next<CR>:args<CR>`                                     | global |
| `<leader>ap`  | `:prev<CR>:args<CR>`                                     | global |
| `<leader>aS`  | `:args `                                                 | global |
| `<leader>as`  | `:args<CR>`                                              | global |

### \<leader\>b — Buffers (15)

| Keys          | Runs                                       | Scope  |
|---------------|--------------------------------------------|--------|
| `<leader>b"`  | `:bnext<CR>:bdelete#<CR>`                  | global |
| `<leader>b$`  | `:blast<CR>`                               | global |
| `<leader>b'`  | `:bdelete#<CR>`                            | global |
| `<leader>b0`  | `:bfirst<CR>`                              | global |
| `<leader>ba`  | `:badd `                                   | global |
| `<leader>bD`  | `:FZFBD<CR>`                               | global |
| `<leader>bd`  | `:bdelete<CR>`                             | global |
| `<leader>be`  | `:edit `                                   | global |
| `<leader>bfd` | `:bufdo `                                  | global |
| `<leader>bn`  | `:bnext<CR>`                               | global |
| `<leader>bo`  | `:%bd\|e#\|bd#<CR>`                          | global |
| `<leader>bp`  | `:bprev<CR>`                               | global |
| `<leader>br`  | `<Plug>lightline#bufferline#reset_order()` | global |
| `<leader>bs`  | `:buffers<CR>`                             | global |
| `<leader>bu`  | `:<C-U>call <SNR>_RevertBuffer()<CR>`      | global |

### \<leader\>c — Comment / cursor / colorscheme (20)

| Keys          | Runs                                                                                                              | Scope  |
|---------------|-------------------------------------------------------------------------------------------------------------------|--------|
| `<leader>c$`  | `<Plug>NERDCommenterToEOL`                                                                                        | global |
| `<leader>cA`  | `<Plug>NERDCommenterAppend`                                                                                       | global |
| `<leader>ca`  | `<Plug>NERDCommenterAltDelims`                                                                                    | global |
| `<leader>cc`  | `<Plug>NERDCommenterComment`                                                                                      | global |
| `<leader>cd`  | `:if &buftype ==# '' && isdirectory(expand('%:p:h')) \| cd %:p:h \| pwd \| else \| echo 'No file directory for this…` | global |
| `<leader>ch`  | `:set cursorline!<CR>:echo 'Toggle Cursor Line [Horizontal]'<CR>`                                                 | global |
| `<leader>chk` | `:HexokinaseToggle<CR>`                                                                                           | global |
| `<leader>cl`  | `:set list!<CR>`                                                                                                  | global |
| `<leader>csD` | `:colorscheme default<CR>:set termguicolors<CR>:call CustomizedColorPalette()<CR>:call LightlineStyle('default'…` | global |
| `<leader>csd` | `:colorscheme dracula<CR>:set termguicolors<CR>:call CustomizedColorPalette()<CR>:call LightlineStyle('dracula'…` | global |
| `<leader>csg` | `:colorscheme gruvbox<CR>:set termguicolors<CR>:call CustomizedColorPalette()<CR>:call LightlineStyle('gruvbox'…` | global |
| `<leader>csn` | `:colorscheme nord<CR>:set termguicolors<CR>:call CustomizedColorPalette()<CR>:call LightlineStyle('nord', g:vi…` | global |
| `<leader>css` | `:colorscheme srcery<CR>:set termguicolors<CR>:call CustomizedColorPalette()<CR>:call LightlineStyle('srcery_dr…` | global |
| `<leader>cst` | `:highlight Normal cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE<CR>:echo 'transparent ba…` | global |
| `<leader>csv` | `:colorscheme vim-monokai-tasty<CR>:set termguicolors<CR>:call CustomizedColorPalette()<CR>:call LightlineStyle…` | global |
| `<leader>csw` | `:colorscheme wal<CR>:set notermguicolors<CR>:call CustomizedColorPalette()<CR>:call LightlineStyle('wal', 1, 1…` | global |
| `<leader>cu`  | `<Plug>NERDCommenterUncomment`                                                                                    | global |
| `<leader>cv`  | `:set cursorcolumn!<CR>:echo 'Toggle Cursor Column [Vertical]'<CR>`                                               | global |
| `<leader>cw`  | `:VimCurrentWordToggle<CR>`                                                                                       | global |
| `<leader>cy`  | `<Plug>NERDCommenterYank`                                                                                         | global |

### \<leader\>D — Debugger (8)

| Keys         | Runs                                                                 | Scope  |
|--------------|----------------------------------------------------------------------|--------|
| `<leader>Db` | `<Plug>VimspectorToggleBreakpoint`                                   | global |
| `<leader>Dc` | `:<C-U>call <SNR>_VimspectorPythonEnv()<CR><Plug>VimspectorContinue` | global |
| `<leader>De` | `<Plug>VimspectorBalloonEval`                                        | global |
| `<leader>Di` | `<Plug>VimspectorStepInto`                                           | global |
| `<leader>Dn` | `<Plug>VimspectorStepOver`                                           | global |
| `<leader>Do` | `<Plug>VimspectorStepOut`                                            | global |
| `<leader>Dq` | `:VimspectorReset<CR>`                                               | global |
| `<leader>Dr` | `:<C-U>call <SNR>_VimspectorPythonEnv()<CR><Plug>VimspectorRestart`  | global |

### \<leader\>d — Diff (9)

| Keys         | Runs                   | Scope  |
|--------------|------------------------|--------|
| `<leader>dD` | `:diffoff<CR>`         | global |
| `<leader>dd` | `:diffthis<CR>`        | global |
| `<leader>dj` | `]c`                   | global |
| `<leader>dk` | `[c`                   | global |
| `<leader>do` | `:diffget `            | global |
| `<leader>dp` | `:diffput `            | global |
| `<leader>ds` | `:diffsplit `          | global |
| `<leader>du` | `:diffupdate<CR>`      | global |
| `<leader>dv` | `:vertical diffsplit ` | global |

### \<leader\>e — Location list / lint / external (10)

| Keys          | Runs                                                            | Scope          |
|---------------|-----------------------------------------------------------------|----------------|
| `<leader>ee`  | `:LspDocumentDiagnostics<CR>`                                   | buffer: python |
| `<leader>eg`  | `:lvimgrep `                                                    | global         |
| `<leader>ehf` | `:%! xxd -r<CR>:echo 'Hex editor off: TF to original data'<CR>` | global         |
| `<leader>eho` | `:%! xxd<CR>:echo 'Hex editor on: TF to binary data'<CR>`       | global         |
| `<leader>ej`  | `:lnext<CR>zz`                                                  | global         |
| `<leader>ek`  | `:lprev<CR>zz`                                                  | global         |
| `<leader>eo`  | `:FZFLocList<CR>`                                               | global         |
| `<leader>esq` | `:r !seq `                                                      | global         |
| `<leader>et`  | `:set expandtab!<CR>`                                           | global         |
| `<leader>ets` | `:r !date<CR>`                                                  | global         |

### \<leader\>f — FZF (43)

| Keys          | Runs                                                            | Scope  |
|---------------|-----------------------------------------------------------------|--------|
| `<leader>f'`  | `:FZFMarks<CR>`                                                 | global |
| `<leader>f*`  | `:execute ":FZFBLines " . expand('<lt>cword>')<CR>`             | global |
| `<leader>f/`  | `:FZFBLines<CR>`                                                | global |
| `<leader>f?`  | `:FZFLines<CR>`                                                 | global |
| `<leader>fag` | `:FZFAg<CR>`                                                    | global |
| `<leader>fbd` | `:FZFBD<CR>`                                                    | global |
| `<leader>fbL` | `:execute ":FZFBLines " . expand('<lt>cword>')<CR>`             | global |
| `<leader>fbl` | `:FZFBLines<CR>`                                                | global |
| `<leader>fbs` | `:FZFBuffers<CR>`                                               | global |
| `<leader>fbT` | `:execute ":FZFBTag " . expand('<lt>cword>')<CR>`               | global |
| `<leader>fbt` | `:FZFBTags<CR>`                                                 | global |
| `<leader>fcd` | `:FZFCommands<CR>`                                              | global |
| `<leader>fcl` | `:FZFChanges<CR>`                                               | global |
| `<leader>fel` | `:FZFLocList<CR>`                                               | global |
| `<leader>ffS` | `:FZFFiles `                                                    | global |
| `<leader>ffs` | `:FZFFiles<CR>`                                                 | global |
| `<leader>fft` | `:FZFFiletypes<CR>`                                             | global |
| `<leader>fgC` | `:call <SNR>_LoadGitPlugin('vim-fugitive')<CR>:FZFCommits<CR>`  | global |
| `<leader>fgc` | `:call <SNR>_LoadGitPlugin('vim-fugitive')<CR>:FZFBCommits<CR>` | global |
| `<leader>fgf` | `:FZFGFiles<CR>`                                                | global |
| `<leader>fgL` | `:execute ":FZFLines " . expand('<lt>cword>')<CR>`              | global |
| `<leader>fgl` | `:FZFLines<CR>`                                                 | global |
| `<leader>fgs` | `:FZFGFiles?<CR>`                                               | global |
| `<leader>fgT` | `:execute ":FZFTag " . expand('<lt>cword>')<CR>`                | global |
| `<leader>fgt` | `:FZFTags<CR>`                                                  | global |
| `<leader>fh/` | `:FZFHistory/<CR>`                                              | global |
| `<leader>fh:` | `:FZFHistory:<CR>`                                              | global |
| `<leader>fhs` | `:FZFHistory<CR>`                                               | global |
| `<leader>fht` | `:FZFHelptags<CR>`                                              | global |
| `<leader>fjl` | `:FZFJumps<CR>`                                                 | global |
| `<leader>flc` | `:FZFLocate `                                                   | global |
| `<leader>fmi` | `:FZFMDInsert<CR>`                                              | global |
| `<leader>fmk` | `:FZFMarks<CR>`                                                 | global |
| `<leader>fmp` | `:FZFMaps<CR>`                                                  | global |
| `<leader>fph` | `:let g:fzf_preview_window = ['left:50%', 'alt-/']<CR>`         | global |
| `<leader>fpj` | `:let g:fzf_preview_window = ['down:50%', 'alt-/']<CR>`         | global |
| `<leader>fpk` | `:let g:fzf_preview_window = ['up:50%', 'alt-/']<CR>`           | global |
| `<leader>fpl` | `:let g:fzf_preview_window = ['right:50%', 'alt-/']<CR>`        | global |
| `<leader>fql` | `:FZFQuickFix<CR>`                                              | global |
| `<leader>frG` | `:FZFRG<CR>`                                                    | global |
| `<leader>frg` | `:FZFRg<CR>`                                                    | global |
| `<leader>frr` | `:FZFRgRoot<CR>`                                                | global |
| `<leader>fws` | `:FZFWindows<CR>`                                               | global |

### \<leader\>g — Git (lazy) / goyo / jumps (30)

| Keys          | Runs                                                                                                     | Scope  |
|---------------|----------------------------------------------------------------------------------------------------------|--------|
| `<leader>g,`  | `:FZFChanges<CR>`                                                                                        | global |
| `<leader>g;`  | `:FZFChanges<CR>`                                                                                        | global |
| `<leader>gA`  | `:Git add %<CR>`                                                                                         | global |
| `<leader>ga`  | `:<C-U>call <SNR>_GitGutterRun('GitGutterStageHunk', 0)<CR>`                                             | global |
| `<leader>gB`  | `:Git blame<CR>`                                                                                         | global |
| `<leader>gb`  | `:GitGutterBufferToggle<CR>`                                                                             | global |
| `<leader>gC`  | `:Git commit<CR>`                                                                                        | global |
| `<leader>gc`  | `:Gclog<CR>`                                                                                             | global |
| `<leader>gD`  | `:Git diff<CR>`                                                                                          | global |
| `<leader>gd`  | `:Git diff %<CR>`                                                                                        | global |
| `<leader>gF`  | `:GitGutterFold<CR>`                                                                                     | global |
| `<leader>gg`  | `:GitGutterToggle<CR>`                                                                                   | global |
| `<leader>ghd` | `:GitGutterEnable<CR>:GitGutterDisable<CR>:GitGutterSignsDisable<CR>:GitGutterLineHighlightsDisable<CR>` | global |
| `<leader>ghe` | `:GitGutterEnable<CR>:GitGutterSignsEnable<CR>:GitGutterLineHighlightsEnable<CR>`                        | global |
| `<leader>ghl` | `:GitGutterLineHighlightsToggle<CR>`                                                                     | global |
| `<leader>ghn` | `:GitGutterLineNrHighlightsToggle<CR>`                                                                   | global |
| `<leader>ghs` | `:GitGutterSignsToggle<CR>`                                                                              | global |
| `<leader>gi`  | `:FZFJumps<CR>`                                                                                          | global |
| `<leader>gj`  | `:<C-U>call <SNR>_GitGutterRun('GitGutterNextHunk', v:count1)<CR>zz`                                     | global |
| `<leader>gk`  | `:<C-U>call <SNR>_GitGutterRun('GitGutterPrevHunk', v:count1)<CR>zz`                                     | global |
| `<leader>gl`  | `:Gllog<CR>`                                                                                             | global |
| `<leader>gm`  | `:Gvdiffsplit!<CR>`                                                                                      | global |
| `<leader>go`  | `:FZFJumps<CR>`                                                                                          | global |
| `<leader>gP`  | `:<C-U>call <SNR>_GitGutterRun('GitGutterPreviewHunk', 0)<CR>`                                           | global |
| `<leader>gq`  | `:GitGutterQuickFix<CR>`                                                                                 | global |
| `<leader>gR`  | `:Git reset `                                                                                            | global |
| `<leader>gr`  | `:<C-U>call <SNR>_GitGutterRun('GitGutterUndoHunk', 0)<CR>`                                              | global |
| `<leader>gs`  | `:Git<CR>`                                                                                               | global |
| `<leader>gv`  | `:Gvdiffsplit<CR>`                                                                                       | global |
| `<leader>gy`  | `:Goyo<CR>`                                                                                              | global |

### \<leader\>h — Easymotion (1)

| Keys        | Runs                              | Scope  |
|-------------|-----------------------------------|--------|
| `<leader>h` | `<Plug>(easymotion-linebackward)` | global |

### \<leader\>i — Insert date (2)

| Keys          | Runs                                            | Scope  |
|---------------|-------------------------------------------------|--------|
| `<leader>idd` | `<Esc>i<C-R>=strftime('%F')<CR>`                | global |
| `<leader>ids` | `<Esc>i<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>` | global |

### \<leader\>j — Easymotion (1)

| Keys        | Runs                   | Scope  |
|-------------|------------------------|--------|
| `<leader>j` | `<Plug>(easymotion-j)` | global |

### \<leader\>k — Easymotion (1)

| Keys        | Runs                   | Scope  |
|-------------|------------------------|--------|
| `<leader>k` | `<Plug>(easymotion-k)` | global |

### \<leader\>L — LSP / LSP features / LanguageTool (23)

| Keys          | Runs                                                                  | Scope          |
|---------------|-----------------------------------------------------------------------|----------------|
| `<leader>La`  | `<Plug>(lsp-code-action)`                                             | buffer: python |
| `<leader>LC`  | `<Esc>:LanguageToolCheck<CR>`                                         | global         |
| `<leader>Lc`  | `<Esc>:LanguageToolClear<CR>`                                         | global         |
| `<leader>Ld`  | `:call DisableLSP(1)<CR>`                                             | global         |
| `<leader>Le`  | `:call EnableLSP()<CR>`                                               | global         |
| `<leader>Lf`  | `:LspDocumentFormatSync<CR>`                                          | buffer: python |
| `<leader>LI`  | `:LspInstallServer<CR>`                                               | global         |
| `<leader>LM`  | `:LspManageServers<CR>`                                               | global         |
| `<leader>Lp`  | `:call DisableLSP(0)<CR>`                                             | global         |
| `<leader>LR`  | `:LspStopServer!<CR>:call <SID>LspDisable()<CR>:call EnableLSP()<CR>` | global         |
| `<leader>LS`  | `:LspStopServer `                                                     | global         |
| `<leader>Ls`  | `:LspStatus<CR>`                                                      | global         |
| `<leader>Lta` | `:<C-U>LspFeature code_action<CR>`                                    | global         |
| `<leader>Ltc` | `:<C-U>LspFeature completion<CR>`                                     | global         |
| `<leader>Ltd` | `:<C-U>LspFeature diagnostics<CR>`                                    | global         |
| `<leader>Lti` | `:<C-U>LspFeature inlay_hints<CR>`                                    | global         |
| `<leader>Lto` | `:<C-U>LspFeature all on<CR>`                                         | global         |
| `<leader>LT`  | `:<C-U>LspFeature all<CR>`                                            | global         |
| `<leader>Ltp` | `:<C-U>LspFeature doc_preview<CR>`                                    | global         |
| `<leader>Ltr` | `:<C-U>LspFeature references<CR>`                                     | global         |
| `<leader>Lts` | `:<C-U>LspFeature signature<CR>`                                      | global         |
| `<leader>Ltt` | `:<C-U>LspFeature<CR>`                                                | global         |
| `<leader>Ltv` | `:<C-U>LspFeature virtual_text<CR>`                                   | global         |

### \<leader\>l — Easymotion (1)

| Keys        | Runs                             | Scope  |
|-------------|----------------------------------|--------|
| `<leader>l` | `<Plug>(easymotion-lineforward)` | global |

### \<leader\>m — Marks / man / markdown-tools (58)

| Keys               | Runs                                                                                                              | Scope            |
|--------------------|-------------------------------------------------------------------------------------------------------------------|------------------|
| `<leader>mB`       | ```` <Esc>i```<CR>```<Up> ````                                                                                    | buffer: markdown |
| `<leader>mb`       | `<Esc>i- [ ]`                                                                                                     | buffer: markdown |
| `<leader>mC`       | `<Esc>a<lt>/span><Esc>`                                                                                           | buffer: markdown |
| `<leader>mc`       | `<Esc>i<lt>span style="color:"><Esc>F<lt><Esc>19<Right>i`                                                         | buffer: markdown |
| `<leader>md`       | `:delmarks `                                                                                                      | global           |
| `<leader>mdd`      | `:delmarks!<CR>`                                                                                                  | global           |
| `<leader>mfA`      | `:call MarkdownTools_FindAllPathsAndWebsites()<CR>`                                                               | buffer: markdown |
| `<leader>mfa"`     | `:call MarkdownTools_ConvertRelativeToAbsolute('"')<CR>`                                                          | buffer: markdown |
| `<leader>mfa'`     | `:call MarkdownTools_ConvertRelativeToAbsolute("'")<CR>`                                                          | buffer: markdown |
| `<leader>mfa(`     | `:call MarkdownTools_ConvertRelativeToAbsolute('(')<CR>`                                                          | buffer: markdown |
| `<leader>mfa)`     | `:call MarkdownTools_ConvertRelativeToAbsolute('(')<CR>`                                                          | buffer: markdown |
| `` <leader>mfa` `` \| `` :call MarkdownTools_ConvertRelativeToAbsolute('`')<CR> ``                                                      | buffer: markdown |
| `<leader>mfaw`     | `:call MarkdownTools_ConvertRelativeToAbsolute('W')<CR>`                                                          | buffer: markdown |
| `<leader>mfb`      | `:call MarkdownTools_FindBacklinks()<CR>`                                                                         | buffer: markdown |
| `<leader>mfc`      | `:call MarkdownTools_ConvertImgHtmlToMarkdown()<CR>`                                                              | buffer: markdown |
| `<leader>mfd`      | `<Esc>:keeppatterns %s/YYYY-mm-DD HH:MM:SS/\=strftime("%Y-%m-%d %T")/g<CR>:keeppatterns %s/YYYY-mm-DD/\=strftim…` | buffer: markdown |
| `<leader>mfe"`     | `:call MarkdownTools_ToggleEnvPath('"')<CR>`                                                                      | buffer: markdown |
| `<leader>mfe'`     | `:call MarkdownTools_ToggleEnvPath("'")<CR>`                                                                      | buffer: markdown |
| `<leader>mfe(`     | `:call MarkdownTools_ToggleEnvPath('(')<CR>`                                                                      | buffer: markdown |
| `<leader>mfe)`     | `:call MarkdownTools_ToggleEnvPath('(')<CR>`                                                                      | buffer: markdown |
| `<leader>mfe1`     | `:!marp % --html<CR>`                                                                                             | buffer: markdown |
| `<leader>mfe2`     | `:!pandoc % -f markdown -t html --standalone --data-dir=$HOME/.pandoc --template=bootstrap_menu.html -o %:r.htm…` | buffer: markdown |
| `<leader>mfe3`     | `:!pandoc % -f markdown -t html --standalone --data-dir=$HOME/.pandoc --template=bootstrap_menu.html -o %:r.htm…` | buffer: markdown |
| `<leader>mfe4`     | `:<C-U><C-R>=<SNR>_GetExportMd2PdfCmd()<CR> --filter pandoc-citeproc `                                            | buffer: markdown |
| `<leader>mfe5`     | `:!soffice --headless --infilter="HTML (StarWriter)" --convert-to "docx:MS Word 2007 XML" %:r.html<CR>`           | buffer: markdown |
| `` <leader>mfe` `` \| `` :call MarkdownTools_ToggleEnvPath('`')<CR> ``                                                                  | buffer: markdown |
| `<leader>mfew`     | `:call MarkdownTools_ToggleEnvPath('W')<CR>`                                                                      | buffer: markdown |
| `<leader>mff`      | `:call MarkdownTools_FindFilepathsOnly()<CR>`                                                                     | buffer: markdown |
| `<leader>mfg`      | `:call MarkdownTools_LiveGrepVault()<CR>`                                                                         | buffer: markdown |
| `<leader>mfH`      | `:vimgrep /^#/ %<CR>`                                                                                             | buffer: markdown |
| `<leader>mfh`      | `:lvimgrep /^#/ %<CR>`                                                                                            | buffer: markdown |
| `<leader>mfI`      | `:call MarkdownTools_InsertMarkdownTemplate()<CR>`                                                                | buffer: markdown |
| `<leader>mfi`      | `:call MarkdownTools_InsertWikiLink()<CR>`                                                                        | buffer: markdown |
| `<leader>mfj`      | `:execute 'r !' . g:vimrc_tools.jrnl_collect<CR>`                                                                 | global           |
| `<leader>mfL`      | `:call MarkdownTools_LocalizeResources()<CR>`                                                                     | buffer: markdown |
| `<leader>mfo`      | `:call MarkdownTools_FindOutlinks()<CR>`                                                                          | buffer: markdown |
| `<leader>mfP`      | `:call MarkdownTools_CaptureAndPasteImage()<CR>`                                                                  | buffer: markdown |
| `<leader>mfp`      | `:call MarkdownTools_PasteClipboardImage()<CR>`                                                                   | buffer: markdown |
| `<leader>mfR`      | `:call MarkdownTools_RenameFilePath()<CR>`                                                                        | buffer: markdown |
| `<leader>mfr"`     | `:call MarkdownTools_ConvertAbsoluteToRelative('"')<CR>`                                                          | buffer: markdown |
| `<leader>mfr'`     | `:call MarkdownTools_ConvertAbsoluteToRelative("'")<CR>`                                                          | buffer: markdown |
| `<leader>mfr(`     | `:call MarkdownTools_ConvertAbsoluteToRelative('(')<CR>`                                                          | buffer: markdown |
| `<leader>mfr)`     | `:call MarkdownTools_ConvertAbsoluteToRelative('(')<CR>`                                                          | buffer: markdown |
| `` <leader>mfr` `` \| `` :call MarkdownTools_ConvertAbsoluteToRelative('`')<CR> ``                                                      | buffer: markdown |
| `<leader>mfrw`     | `:call MarkdownTools_ConvertAbsoluteToRelative('W')<CR>`                                                          | buffer: markdown |
| `<leader>mfw`      | `:call MarkdownTools_FindWebsitesOnly()<CR>`                                                                      | buffer: markdown |
| `<leader>mI`       | `<Esc>i<lt>img src="" title="" width="100%" height="100%"/><Esc>38<Left>i`                                        | buffer: markdown |
| `<leader>mi`       | `<Esc>i![this_is_an_image]()<Left>`                                                                               | buffer: markdown |
| `<leader>mk`       | `:FZFMarks<CR>`                                                                                                   | global           |
| `<leader>ml`       | `<Esc>i[this_is_a_link]()<Left>`                                                                                  | buffer: markdown |
| `<leader>mM`       | `:execute ":Man " . expand('<lt>cword>')<CR>`                                                                     | global           |
| `<leader>mm`       | `:Man `                                                                                                           | global           |
| `<leader>mO`       | `:exe '!'. g:md_tools_browser .' %:p &'<CR>`                                                                      | buffer: markdown |
| `<leader>mo`       | `:call MarkdownTools_OpenFileOrLink()<CR>`                                                                        | buffer: markdown |
| `<leader>mP`       | `:exe '!'. g:md_tools_browser .' %:r.html &'<CR>`                                                                 | buffer: markdown |
| `<leader>mT`       | `:execute('r ' . g:md_tools_table_template)<CR>`                                                                  | buffer: markdown |
| `<leader>mV`       | `<Esc>i<lt>video src="" title="" width="100%" height="100%" controls/><Esc>47<Left>i`                             | buffer: markdown |
| `<leader>mw`       | `<Esc>i::<Esc>i`                                                                                                  | buffer: markdown |

### \<leader\>n — Neoformat (14)

| Keys           | Runs                                       | Scope  |
|----------------|--------------------------------------------|--------|
| `<leader>ncf`  | `:Neoformat clangformat<CR>`               | global |
| `<leader>nmf`  | `:<C-U>call <SNR>_MdformatWithPatch()<CR>` | global |
| `<leader>nn`   | `:Neoformat<CR>`                           | global |
| `<leader>npi`  | `:Neoformat isort<CR>`                     | global |
| `<leader>npR`  | `:Neoformat ruffimport<CR>`                | global |
| `<leader>npr`  | `:Neoformat ruff<CR>`                      | global |
| `<leader>nptg` | `:Neoformat pyment_google<CR>`             | global |
| `<leader>nptj` | `:Neoformat pyment_javadoc<CR>`            | global |
| `<leader>nptn` | `:Neoformat pyment_numpydoc<CR>`           | global |
| `<leader>nptt` | `:Neoformat pyment<CR>`                    | global |
| `<leader>npy`  | `:Neoformat yapf<CR>`                      | global |
| `<leader>nsf`  | `:Neoformat! sql sqlformat<CR>`            | global |
| `<leader>ntl`  | `:let g:NERDTreeWinPos = 'left'<CR>`       | global |
| `<leader>ntr`  | `:let g:NERDTreeWinPos = 'right'<CR>`      | global |

### \<leader\>o — AI (vim-ai) (4)

| Keys         | Runs          | Scope  |
|--------------|---------------|--------|
| `<leader>oe` | `:AIE `       | global |
| `<leader>oi` | `:AI `        | global |
| `<leader>oo` | `:AIC `       | global |
| `<leader>or` | `:AIRedo<CR>` | global |

### \<leader\>p — Python / tests / run / virtualenv (11)

| Keys          | Runs                                                                                                      | Scope          |
|---------------|-----------------------------------------------------------------------------------------------------------|----------------|
| `<leader>pB`  | `:<C-U>update<C-R>=g:vimrc_is_nvim ? ' <Bar> split' : ''<CR><CR>:<C-R>=<SNR>_PythonDebugCmd()<CR><Space>` | buffer: python |
| `<leader>pb`  | `Obreakpoint()<Esc>`                                                                                      | buffer: python |
| `<leader>pl`  | `:<C-U>call <SNR>_TmuxRunLast()<CR>`                                                                      | global         |
| `<leader>ptf` | `:TestFile<CR>`                                                                                           | global         |
| `<leader>ptl` | `:TestLast<CR>`                                                                                           | global         |
| `<leader>ptn` | `:TestNearest<CR>`                                                                                        | global         |
| `<leader>pts` | `:TestSuite<CR>`                                                                                          | global         |
| `<leader>ptv` | `:TestVisit<CR>`                                                                                          | global         |
| `<leader>pV`  | `:ProjectVenv!<CR>`                                                                                       | global         |
| `<leader>pv`  | `:ProjectVenv<CR>`                                                                                        | global         |
| `<leader>px`  | `:<C-U>call <SNR>_TmuxRunFile()<CR>`                                                                      | global         |

### \<leader\>q — Quit / quickfix (11)

| Keys          | Runs                                                | Scope  |
|---------------|-----------------------------------------------------|--------|
| `<leader>q!`  | `:q!<CR>`                                           | global |
| `<leader>qa`  | `:qall<CR>`                                         | global |
| `<leader>qa!` | `:qall!<CR>`                                        | global |
| `<leader>qd`  | `:cdo `                                             | global |
| `<leader>qg`  | `:vimgrep `                                         | global |
| `<leader>qj`  | `:cnext<CR>zz`                                      | global |
| `<leader>qk`  | `:cprev<CR>zz`                                      | global |
| `<leader>qo`  | `:FZFQuickFix<CR>`                                  | global |
| `<leader>qq`  | `:q<CR>`                                            | global |
| `<leader>qt`  | `:<C-U>call <SNR>_TmuxPaneToQuickfix('target')<CR>` | global |
| `<leader>qT`  | `:<C-U>call <SNR>_TmuxPaneToQuickfix('run')<CR>`    | global |

### \<leader\>r — Registers / resize / rg / rename (11)

| Keys          | Runs                                        | Scope          |
|---------------|---------------------------------------------|----------------|
| `<leader>rb`  | `:RainbowToggle<CR>`                        | global         |
| `<leader>re`  | `<Plug>(lsp-rename)`                        | buffer: python |
| `<leader>rG`  | `:FZFRG<CR>`                                | global         |
| `<leader>rg`  | `:FZFRg<CR>`                                | global         |
| `<leader>rh2` | `:call ResizeHeightToFraction(1.0/2.0)<CR>` | global         |
| `<leader>rh3` | `:call ResizeHeightToFraction(1.0/3.0)<CR>` | global         |
| `<leader>rh4` | `:call ResizeHeightToFraction(1.0/4.0)<CR>` | global         |
| `<leader>rr`  | `:registers<CR>`                            | global         |
| `<leader>rw2` | `:call ResizeWidthToFraction(1.0/2.0)<CR>`  | global         |
| `<leader>rw3` | `:call ResizeWidthToFraction(1.0/3.0)<CR>`  | global         |
| `<leader>rw4` | `:call ResizeWidthToFraction(1.0/4.0)<CR>`  | global         |

### \<leader\>s — Spell / scrolloff / statusline (16)

| Keys           | Runs                                                                                                              | Scope  |
|----------------|-------------------------------------------------------------------------------------------------------------------|--------|
| `<leader>sag`  | `<Esc>zg`                                                                                                         | global |
| `<leader>saw`  | `<Esc>zw`                                                                                                         | global |
| `<leader>sj`   | `]s`                                                                                                              | global |
| `<leader>sk`   | `[s`                                                                                                              | global |
| `<leader>sl`   | `:set spell!<CR>`                                                                                                 | global |
| `<leader>slad` | `:call lightline#disable()<CR>:set showmode<CR>:set showtabline=0<CR>:set laststatus=0<CR>:echo "STATUSLINE/TAB…` | global |
| `<leader>slae` | `:call lightline#enable()<CR>:set noshowmode<CR>:set showtabline=2<CR>:set laststatus=2<CR>:echo "STATUSLINE/TA…` | global |
| `<leader>slsd` | `:call lightline#disable()<CR>:set showmode<CR>:set laststatus=2<CR>:echo "LIGHTLINE DISABLED"<CR>`               | global |
| `<leader>slse` | `:call lightline#enable()<CR>:set noshowmode<CR>:set laststatus=2<CR>:echo "LIGHTLINE ENABLED"<CR>`               | global |
| `<leader>sltd` | `:set showtabline=0<CR>:echo "TABLINE DISABLED"<CR>`                                                              | global |
| `<leader>slte` | `:set showtabline=2<CR>:echo "TABLINE ENABLED"<CR>`                                                               | global |
| `<leader>so-`  | `:set scrolloff=0<CR>`                                                                                            | global |
| `<leader>so0`  | `:set scrolloff=10<CR>`                                                                                           | global |
| `<leader>so=`  | `:set scrolloff=999<CR>`                                                                                          | global |
| `<leader>srg`  | `<Esc>zug`                                                                                                        | global |
| `<leader>srw`  | `<Esc>zuw`                                                                                                        | global |

### \<leader\>T — Toggles (echo new state) (16)

| Keys         | Runs                                                  | Scope  |
|--------------|-------------------------------------------------------|--------|
| `<leader>Ta` | `:<C-U>call <SNR>_ToggleOption('autochdir')<CR>`      | global |
| `<leader>Tb` | `:<C-U>call <SNR>_ToggleCommand('RainbowToggle')<CR>` | global |
| `<leader>Tc` | `:<C-U>call <SNR>_ToggleOption('cursorline')<CR>`     | global |
| `<leader>Td` | `:<C-U>call <SNR>_ToggleCommand('ALEToggle')<CR>`     | global |
| `<leader>Te` | `:<C-U>call <SNR>_ToggleOption('expandtab')<CR>`      | global |
| `<leader>Tf` | `:<C-U>call <SNR>_ToggleFormatOnSave()<CR>`           | global |
| `<leader>Tg` | `:<C-U>call <SNR>_ToggleCommand('Goyo')<CR>`          | global |
| `<leader>Tk` | `:<C-U>call <SNR>_ToggleCompletionPopup()<CR>`        | global |
| `<leader>Tl` | `:<C-U>call <SNR>_ToggleOption('list')<CR>`           | global |
| `<leader>Tn` | `:<C-U>call <SNR>_ToggleOption('number')<CR>`         | global |
| `<leader>Tp` | `:<C-U>call <SNR>_ToggleOption('paste')<CR>`          | global |
| `<leader>Tr` | `:<C-U>call <SNR>_ToggleOption('relativenumber')<CR>` | global |
| `<leader>Ts` | `:<C-U>call <SNR>_ToggleOption('spell')<CR>`          | global |
| `<leader>Tt` | `:<C-U>call <SNR>_ToggleCommand('TagbarToggle')<CR>`  | global |
| `<leader>Tv` | `:<C-U>call <SNR>_ToggleOption('cursorcolumn')<CR>`   | global |
| `<leader>Tw` | `:<C-U>call <SNR>_ToggleOption('wrap')<CR>`           | global |

### \<leader\>t — Tabs / terminal / tagbar (21)

| Keys          | Runs                                                                 | Scope  |
|---------------|----------------------------------------------------------------------|--------|
| `<leader>t$`  | `:tablast<CR>`                                                       | global |
| `<leader>t0`  | `:tabfirst<CR>`                                                      | global |
| `<leader>ta`  | `:tabnew `                                                           | global |
| `<leader>tbd` | `:tabdo `                                                            | global |
| `<leader>tD`  | `:tabclose `                                                         | global |
| `<leader>td`  | `:tabclose<CR>`                                                      | global |
| `<leader>te`  | `:tabedit `                                                          | global |
| `<leader>tf`  | `:tabfind `                                                          | global |
| `<leader>tgl` | `:let g:tagbar_position = 'leftabove vertical'<CR>`                  | global |
| `<leader>tgr` | `:let g:tagbar_position = 'botright vertical'<CR>`                   | global |
| `<leader>tl`  | `:TaskList<CR>`                                                      | global |
| `<leader>tm`  | `:split<CR>:terminal<CR>i`                                           | global |
| `<leader>tN`  | `:execute 'silent! tabmove ' . (tabpagenr()+1)<CR>`                  | global |
| `<leader>tn`  | `:tabnext<CR>`                                                       | global |
| `<leader>tO`  | `:tab ball<CR>`                                                      | global |
| `<leader>to`  | `:tabonly<CR>`                                                       | global |
| `<leader>tP`  | `:execute 'silent! tabmove ' . (tabpagenr()-2)<CR>`                  | global |
| `<leader>tp`  | `:tabprevious<CR>`                                                   | global |
| `<leader>tr`  | `:split<CR>:terminal ranger<CR>`                                     | global |
| `<leader>ts`  | `:tabs<CR>`                                                          | global |
| `<leader>tt`  | `:split<CR>:terminal env -u TMUX tmux new-session -A -s scratch<CR>` | global |

### \<leader\>u — Undo tree (1)

| Keys         | Runs               | Scope  |
|--------------|--------------------|--------|
| `<leader>ut` | `:MundoToggle<CR>` | global |

### \<leader\>w — Write / wiki / wrap (32)

| Keys            | Runs                                                            | Scope  |
|-----------------|-----------------------------------------------------------------|--------|
| `<leader>w!`    | `:call RemoveTrailingWhitespace()<CR>:w!<CR>`                   | global |
| `<leader>w-`    | `:set iskeyword-=_<CR>`                                         | global |
| `<leader>w/`    | `<Esc>:VimwikiSearch `                                          | global |
| `<leader>w<CR>` | `<Plug>VimwikiGoto`                                             | global |
| `<leader>w=`    | `:set iskeyword+=_<CR>`                                         | global |
| `<leader>wA`    | `:wqall<CR>`                                                    | global |
| `<leader>wa`    | `:wall<CR>`                                                     | global |
| `<leader>wa!`   | `:wall!<CR>`                                                    | global |
| `<leader>wb`    | `<Esc>:VimwikiBacklinks<CR>`                                    | global |
| `<leader>wC`    | `<Esc>:VimwikiCheckLinks<CR>`                                   | global |
| `<leader>wcc`   | `<Esc>:VimwikiColorize<CR>`                                     | global |
| `<leader>wcr`   | `<Esc>:Calendar<CR>`                                            | global |
| `<leader>wD`    | `<Plug>VimwikiDeleteFile`                                       | global |
| `<leader>wdd`   | `<Plug>VimwikiMakeDiaryNote`                                    | global |
| `<leader>wdG`   | `<Plug>VimwikiDiaryGenerateLinks`                               | global |
| `<leader>wdI`   | `<Plug>VimwikiDiaryIndex`                                       | global |
| `<leader>wdn`   | `<Esc>:VimwikiDiaryNextDay<CR>`                                 | global |
| `<leader>wdp`   | `<Esc>:VimwikiDiaryPrevDay<CR>`                                 | global |
| `<leader>wI`    | `<Plug>VimwikiIndex`                                            | global |
| `<leader>wN`    | `:%s///ng<Left><Left><Left><Left>`                              | global |
| `<leader>wn`    | `:%s///n<Left><Left><Left>`                                     | global |
| `<leader>wp`    | `:set wrap!<CR>`                                                | global |
| `<leader>wq`    | `:call RemoveTrailingWhitespace()<CR>:wq<CR>`                   | global |
| `<leader>wR`    | `<Plug>VimwikiRenameFile`                                       | global |
| `<leader>ws`    | `<Plug>VimwikiUISelect`                                         | global |
| `<leader>wT`    | `<Esc>:VimwikiTOC<CR>`                                          | global |
| `<leader>wt/`   | `<Esc>:VimwikiSearchTags `                                      | global |
| `<leader>wtG`   | `<Esc>:VimwikiGenerateTagLinks<CR>`                             | global |
| `<leader>wtR`   | `<Esc>:VimwikiRebuildTags<CR>`                                  | global |
| `<leader>wtt`   | `<Esc>:VimwikiTable<CR>`                                        | global |
| `<leader>ww`    | `:call RemoveTrailingWhitespace()<CR>:w<CR>`                    | global |
| `<leader>wyy`   | `<Esc>:VimwikiPasteLink<CR>jddk:echo 'Current Link Yanked'<CR>` | global |

### \<leader\>x — Send to tmux pane / run pane (7)

| Keys         | Runs                                                                        | Scope  |
|--------------|-----------------------------------------------------------------------------|--------|
| `<leader>xc` | `:<C-U>call <SNR>_TmuxSendCell()<CR>`                                       | global |
| `<leader>xd` | `:<C-U>call <SNR>_TmuxSendDiagnostics()<CR>`                                | global |
| `<leader>xr` | `:<C-U>call <SNR>_TmuxSendRef(line('.'), line('.'))<CR>`                    | global |
| `<leader>xT` | `:<C-U>call <SNR>_TmuxChooseTarget('run_target')<CR>`                       | global |
| `<leader>xt` | `:<C-U>call <SNR>_TmuxChooseTarget('target')<CR>`                           | global |
| `<leader>xx` | `:<C-U>call TmuxSendText(getline('.'), <SNR>_EnterCount(getline('.')))<CR>` | global |
| `<leader>xy` | `:<C-U>call TmuxSendText(getline('.'), 0)<CR>`                              | global |

### \<leader\>y — Yank / path (5)

| Keys         | Runs                                                                    | Scope  |
|--------------|-------------------------------------------------------------------------|--------|
| `<leader>yC` | `:YRClear<CR>`                                                          | global |
| `<leader>yP` | `:set paste!<CR>`                                                       | global |
| `<leader>yp` | `:let @+ = expand('%:p') \| let @* = @+ \| echo 'Yanked path: ' . @+<CR>` | global |
| `<leader>yr` | `:<C-U>call <SNR>_YankRef(line('.'), line('.'))<CR>`                    | global |
| `<leader>ys` | `:YRShow<CR>`                                                           | global |

### \<leader\>z — Maximize (1)

| Keys        | Runs                   | Scope  |
|-------------|------------------------|--------|
| `<leader>z` | `:MaximizerToggle<CR>` | global |

### \<leader\>… — Other (non-letter keys) (19)

| Keys              | Runs                               | Scope            |
|-------------------|------------------------------------|------------------|
| `<leader>"`       | `<Plug>(choosewin)`                | global           |
| `<leader>'`       | `:FZFBuffers<CR>`                  | global           |
| `<leader>/`       | `<Plug>(easymotion-sn)`            | global           |
| `<leader><BS>`    | `<Plug>VimwikiGoBackLink`          | global           |
| `<leader><CR>`    | `<Plug>VimwikiFollowLink`          | global           |
| `<leader><F10>`   | `:loadview<CR>`                    | global           |
| `<leader><F11>`   | `:set nocursorbind<CR>`            | global           |
| `<leader><F3>`    | `:silent! NERDTreeFind<CR>`        | global           |
| `<leader><F4>`    | `<Plug>MarkdownPreviewToggle`      | buffer: markdown |
| `<leader><F5>`    | `:set number!<CR>`                 | global           |
| `<leader><F6>`    | `:call FoldColumnToggleLong()<CR>` | global           |
| `<leader><F7>`    | `:call OverlengthToggle()<CR>`     | global           |
| `<leader><F8>`    | `:call FoldHighlightToggle()<CR>`  | global           |
| `<leader><F9>`    | `:IndentGuidesToggle<CR>`          | global           |
| `<leader><S-Tab>` | `:jumps<CR>`                       | global           |
| `<leader><Tab>`   | `:jumps<CR>`                       | global           |
| `<leader>\`       | `<Esc>:VimwikiToggleListItem<CR>`  | global           |
| `` <leader>` ``   \| `:call AutoCompPopToggle()<CR>`    | global           |
| `<leader>\|`       | `:<Esc>i[^]<Left>`                 | buffer: markdown |
