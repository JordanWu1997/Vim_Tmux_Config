# Getting Started with Vim + tmux

For new users of the configuration in `Vim_Tmux_Config` · 2026-11-05. Next steps: the **User Guide** (`vim-tmux-user-guide`) and the **Agent Workflow Tutorial** (`agent-workflow-tutorial`).

New to Vim, tmux or this configuration? Start here: install it, learn how keys are written, and try the keys you need on day one. The other guides and the README are for later.

## What You Get

- **Vim/Neovim** set up like a light IDE for Python: file search, completion, go-to-definition, linting, formatting, tests and a debugger. Most of it stays off until you ask for it, so Vim starts fast.
- **tmux** (a terminal "window manager") with Vim-like keys, so one terminal holds your editor, a shell and a coding agent next to each other.
- **Vim and tmux work together**: the same keys move between Vim splits and tmux panes, Vim sends code or file references to another pane, and reads test or agent output back.
- **Notes** in Markdown (vimwiki), with a daily diary, links, preview and export.

## What You Need

| Tool                       | Version     | Check with          |
|----------------------------|-------------|---------------------|
| Neovim (or Vim)            | 0.9+ (9.1+) | `nvim --version`    |
| tmux                       | 3.2+        | `tmux -V`           |
| git, curl                  | any         | `git --version`     |
| Python 3 (for Python work) | 3.8+        | `python3 --version` |

Optional extras (installed later, see "Preparation for Dependence" in the [README](../../README.md#1-preparation-for-dependence-vim)): `fzf`, `ripgrep`, `xsel` (clipboard), `ruff`, `pytest`, Node.js (some language servers).

## Install in 5 Steps

1.  Clone the repository **to this exact place** (the tmux status bar and some keys look for their scripts here):

    ``` sourceCode
    git clone <this-repository-url> ~/Desktop/Vim_Tmux_Config
    cd ~/Desktop/Vim_Tmux_Config
    ```

2.  Link the config files, so a later `git pull` updates them. If you already have these files, move them away first (e.g. `mv ~/.tmux.conf ~/.tmux.conf.bak`), or `ln -s` stops with "File exists":

    ``` sourceCode
    mkdir -p ~/.config/nvim
    ln -s "$PWD/vim/vimrc" ~/.config/nvim/init.vim   # Neovim
    ln -s "$PWD/vim/vimrc" ~/.vimrc                  # Vim (optional)
    ln -s "$PWD/tmux/tmux.conf" ~/.tmux.conf         # tmux
    ```

3.  Start tmux: `tmux`. The first start downloads the tmux plugins by itself (give it a minute). You should see a status bar along the bottom. If tmux was already running before step 2, run `tmux kill-server` first (this closes all tmux sessions), then `tmux`.

4.  Start Neovim: `nvim`. The first start downloads the Vim plugins into a split window; wait until it says `Finished`. Then type `:qa` and press `Enter` to quit, and start `nvim` again.

5.  Optional, for Python: `pip install --user ruff pytest ipdb` (or install them in your project's virtualenv; plain `pip install` may refuse with "externally-managed-environment"), then open any `.py` file in Neovim and run `:LspInstallServer pylsp-all`.

## How to Read the Key Tables

| Written as                    | Means                                                                                       |
|-------------------------------|---------------------------------------------------------------------------------------------|
| `[LK]`                        | The Vim **leader key** = `Space`                                                            |
| `[BK]` or "prefix"            | The tmux **prefix** = `Ctrl`+`b` (or `Ctrl`+`a`). Press it, let go, then press the next key |
| `[LK]`+`[f]`+`[g]`+`[f]`      | Press the keys **one after another**: `Space`, `f`, `g`, `f`                                |
| `[Ctrl]`+`[w]`                | Hold `Ctrl` and press `w` at the same time                                                  |
| `[Shift]`+`[l]`               | Capital `L`                                                                                 |
| `[Alt]`+`[d]`                 | Hold `Alt` and press `d`                                                                    |
| N / V / I (VIM-Mode)          | The key works in Normal / Visual / Insert mode                                              |
| `<leader>ffs` (in the guides) | Same as `[LK]`+`[f]`+`[f]`+`[s]`                                                            |
| `:w`                          | Type `:w` in Normal mode and press `Enter`                                                  |

Stuck? In Vim press `Space` and wait: a menu (which-key) lists what comes next. In tmux, prefix `?` lists every key. `Esc` (or typing `kj`) always gets you back to Vim's normal mode.

## Words You Will See

| Word                           | Meaning                                                                                                                    |
|--------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Buffer                         | A file opened in Vim (it stays open even when it isn't on screen)                                                          |
| Split                          | Vim's screen divided into several views (Vim also calls them windows)                                                      |
| Session / window / pane (tmux) | A tmux **session** holds **windows** (like browser tabs); a window is divided into **panes**, each running its own program |
| Normal / Insert mode           | In Normal mode keys are commands; in Insert mode they type text (`i` to insert, `Esc` to leave)                            |
| Quickfix list                  | A list of file positions (search hits, test failures, errors) you can jump through                                         |
| LSP                            | Language server: the program that gives completion, go-to-definition and error checking                                    |
| Agent                          | An AI coding assistant running in a terminal pane, e.g. Claude Code                                                        |

## Your First 15 Minutes

| Do this                                      | Keys                                                                         |
|----------------------------------------------|------------------------------------------------------------------------------|
| Open a file by name                          | `[LK]`+`[f]`+`[g]`+`[f]` (git files) or `[LK]`+`[f]`+`[f]`+`[s]` (all files) |
| Search text in the project                   | `[LK]`+`[f]`+`[r]`+`[g]`                                                     |
| Switch between open files                    | `[LK]`+`[']`                                                                 |
| Show the file tree                           | `[F3]`                                                                       |
| Leave Insert mode                            | `Esc` or `kj`                                                                |
| Save / quit                                  | `[LK]`+`[w]`+`[w]` / `[LK]`+`[q]`+`[q]` (or `:w`, `:q`)                      |
| Comment a line                               | `[Ctrl]`+`[/]`                                                               |
| Turn on code intelligence (Python)           | `[LK]`+`[Shift]`+`[l]`+`[e]`, then `[g]`+`[d]` goes to a definition          |
| Split the tmux window left/right, top/bottom | prefix `%` / prefix `"`                                                      |
| Move between Vim splits and tmux panes       | `[Ctrl]`+`[h/j/k/l]` (left/down/up/right)                                    |
| Zoom a pane / new tmux window / next window  | prefix `z` / prefix `c` / prefix `n`                                         |
| Leave tmux running in the background         | prefix `d` (come back with `tmux attach`)                                    |

## Where to Go Next

- **User guide**: [vim-tmux-user-guide.html](vim-tmux-user-guide.html) (also `.pdf`), task by task: Python, notes, search, git, and every leader key.
- **Agent workflow tutorial**: [agent-workflow-tutorial.html](agent-workflow-tutorial.html) (also `.pdf`), a hands-on walkthrough of working with Claude Code next to Vim, with examples.
- **The [README](../../README.md)**: install details, feature switches and the full key tables.
