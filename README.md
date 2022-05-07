# Vim_Tmux_Config
Backup for my Vim and TMUX configuration

<details open>
<summary>Click to expand!</summary>

Table of Contents
=================
<details open>
<summary>Click to expand!</summary>

* [Vim_Tmux_Config](#vim_tmux_config)
* [Table of Contents](#table-of-contents)
* [Context](#context)
   * [Demo Current Customization](#demo-current-customization)
   * [Part 1 - Vim/Gvim/Neovim](#part-1---vimgvimneovim)
      * [Section 1 - What's New in My Customization (Vim)](#section-1---whats-new-in-my-customization-vim)
      * [Section 2 - First Time Usage (Vim)](#section-2---first-time-usage-vim)
         * [1. Preparation for Dependence (Vim)](#1-preparation-for-dependence-vim)
         * [2. Copy Configuration File (Vim)](#2-copy-configuration-file-vim)
         * [3. First Time Startup (Vim)](#3-first-time-startup-vim)
      * [Section 3 - Plugin Usage (Vim)](#section-3---plugin-usage-vim)
         * [1. Plugin Loading Time (Vim)](#1-plugin-loading-time-vim)
         * [2. Plugin Usage Configuration (Vim)](#2-plugin-usage-configuration-vim)
      * [Section 4 - Key Mapping (Vim)](#section-4---key-mapping-vim)
         * [Key Mapping - Customized Key Mapping Rule (Vim)](#key-mapping---customized-key-mapping-rule-vim)
         * [Key Mapping Sheet 1 - Fn Key Key Mapping (Vim)](#key-mapping-sheet-1---fn-key-key-mapping-vim)
         * [Key Mapping Sheet 2 - Built-in Function Key Mapping (Vim)](#key-mapping-sheet-2---built-in-function-key-mapping-vim)
         * [Key Mapping Sheet 3 - Plug-in Function Key Mapping (Vim)](#key-mapping-sheet-3---plug-in-function-key-mapping-vim)
         * [Key Mapping Sheet 4 - Vim Whichkey (Vim)](#key-mapping-sheet-4---vim-whichkey-vim)
      * [Reference for Setup (Vim)](#reference-for-setup-vim)
   * [Part 2 - TMUX](#part-2---tmux)
      * [Section 1 - What's New in My Customization (TMUX)](#section-1---whats-new-in-my-customization-tmux)
      * [Section 2 - First Time Usage (TMUX)](#section-2---first-time-usage-tmux)
         * [1. Preparation for Dependence (TMUX)](#1-preparation-for-dependence-tmux)
         * [2. Copy Configuration File (TMUX)](#2-copy-configuration-file-tmux)
         * [3. First Time Startup (TMUX)](#3-first-time-startup-tmux)
      * [Section 3 - Plugin Usage (TMUX)](#section-3---plugin-usage-tmux)
         * [Installed Plugins (TMUX)](#installed-plugins-tmux)
      * [Section 4 - Key Mapping (TMUX)](#section-4---key-mapping-tmux)
         * [Key Mapping - Customized Key Mapping Rule (TMUX)](#key-mapping---customized-key-mapping-rule-tmux)
         * [Key Mapping Sheet 1 - Session/Window/Pane Key Mapping (TMUX)](#key-mapping-sheet-1---sessionwindowpane-key-mapping-tmux)
         * [Key Mapping Sheet 2 - Copy-mode Key Mapping (TMUX)](#key-mapping-sheet-2---copy-mode-key-mapping-tmux)
         * [Key Mapping Sheet 3 - Miscellaneous (TMUX)](#key-mapping-sheet-3---miscellaneous-tmux)
      * [Reference for Setup (TMUX)](#reference-for-setup-tmux)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

</details>

# Context
<details open>
<summary>Click to expand!</summary>

## Demo Current Customization
<details open>
<summary>Click to expand!</summary>

|                 | Color scheme                                                     | More Information                                                                           |
| :-------------: | :--------------------------------------------------------------: | :----------------------------------------------------------------------------------------: |
| Vim/Gvim/Neovim | [Gruvbox](https://github.com/morhetz/gruvbox)                    |                                                                                            |
| TMUX            | 8 pywal-color using [Pywal](https://github.com/dylanaraps/pywal) | For pywal usage, check [My_I3_Environment](https://github.com/JordanWu1997/I3_Sway_Config) |


<details open>
<summary>NEOVIM_DEMO_01</summary>

![alt text](./demo/NEOVIM_DEMO_01.png "Title")

</details>

<details open>
<summary>NEOVIM_DEMO_02</summary>

![alt text](./demo/NEOVIM_DEMO_02.png "Title")

</details>

<details open>
<summary>TMUX_DEMO_01</summary>

![alt text](./demo/TMUX_DEMO_01.png "Title")

</details>
</details>

## Part 1 - Vim/Gvim/Neovim
<details open>
<summary>Click to expand!</summary>

### Section 1 - What's New in My Customization (Vim)
<details open>
<summary>Click to expand!</summary>

> 1. Use **_interchangeable configuration_** for various vim-family e.g vim, gvim, and neovim
> 2. Integrate **_useful vim-plugin_** e.g. auto-pair parentheses, auto-popup completion, and etc.
> 3. Integrate **_various color theme_** for better syntax highlighting e.g. gruvbox, nord, and etc.
> 4. Integrate **_Vim with TMUX_** for both pane/split and clipboard to work together smoothly
> 5. Map built-in/plugin-in function to keys that are easier to remember systematically
> 6. Add IDE-like features for python e.g. linter, formatter, analyzer, and etc.
> 7. Add markdown features e.g. preview, wiki-style markdown writer, and etc.
> 8. Add Latex features e.g. real-time preview, compilation, and etc.
> 9. Try to minimize loading time along with maximal functionality/variety

</details>

### Section 2 - First Time Usage (Vim)
<details>
<summary>Click to expand!</summary>

#### 1. Preparation for Dependence (Vim)

1. Common Requirement
- __Curl__ [for plugin manager setup]
    ```bash
    # For Fedora
    dnf install curl
    ```
- __Web browser with markdown extension__ (e.g. google-chrome, Firefox, and etc.) [for markdown preview]
    ```bash
    # For Fedora
    dnf install firefox
    ```
- __PDF viewer__ (e.g. zathura, Okular) [for latex preview]
    ```bash
    # For Fedora
    dnf install zathura*
    ```

2. Requirement for Diverse Vim
- __Vim__
    - version >= __7.0__
    - clipboard option is on (+clipboard) [for sharing system clipboard]
    - python3 option is on (+python3/dyn) [for python completion]
    ```bash
    # Check vim version and other options
    vim --version
    ```
- __Gvim__
    - version >= __7.0__
    - gvim already shipped with clipboard and python3 options
    ```bash
    # Check gvim version and other options
    vim --version
    ```
- __Neovim__
    - version >= __0.4__
    - neovim already shipped with clipboard and python3 options
    ```bash
    # Check nvim version and other options
    nvim --version
    ```
3. Requirement for Python Completion
- __ipython__ (version >= __7.20__) [python consoler]
    ```bash
    # Python3
    pip install ipython
    ```
- __jedi__ for jedi [python code analyzer]
    ```bash
    # Python3
    pip install jedi
    ```
- __pynvim__ for deoplete neovim plugin usage [python code analyzer]
    ```bash
    # Python3
    pip install pynvim
    ```
- __ipdb__ for ipdb [python breakpoint maker]
    ```bash
    # Python3
    pip install ipdb
    ```

4. Requirements for Basic Latex Compilation
- __texlive__ [latex suite]
    ```bash
    # For Fedora
    dnf install texlive-scheme-basic
    ```

#### 2. Copy Configuration File (Vim)
- __Vim/Gvim__
    1. copy "vimrc" to $HOME (current user's home)
    2. rename "vimrc" to ".vimrc"
    ```bash
    cp vimrc $HOME/.vimrc
    ```
- __Neovim__
    1. copy "vimrc" to $HOME/.config/nvim (create one if not exists)
    2. rename "vimrc" to "init.vim"
    ```bash
    mkdir -p $HOME/nvim
    cp vimrc $HOME/nvim/init.vim
    ```

#### 3. First Time Startup (Vim)
- Following installation should start automatically at the first time startup
    1. vim-plug (plug manager) installation via __curl__
        - If not working, try manually install vim-plug (also within this repository)
            ```bash
            # For vim/gvim
            cp -r vim/autoload $HOME/.vim
            # For neovim
            cp -r vim/autoload $HOME/.config/nvim
            ```
    2. vim plugin installation via __vim-plug__
        - If not working, try manually install vim-Plug
            ```bash
            # In vim command line mode
            :Pluginstall
            ```

</details>

### Section 3 - Plugin Usage (Vim)
<details>
<summary>Click to expand!</summary>

#### 1. Plugin Loading Time (Vim)
- Enable too much plugins may slow down your vim. You can check your loading time with following command
- For managing plugins enable/disable, see next section (Plugin usage configuration)
```bash
# For vim/gvim
vim --startuptime /tmp/startup.log FILE_TO_TEST +q && vim /tmp/startup.log
# For neovim
vim --startuptime /tmp/startup.log FILE_TO_TEST +q && vim /tmp/startup.log
```

#### 2. Plugin Usage Configuration (Vim)
for more details, check sections in vimrc

- Plugin usage can be configured in the first section of vimrc
    ```vim
    " ============================================================================
    " Vim and Neovim settings
    " ============================================================================
    " Select vim-plug to load, set GUI color (real color) support, and etc.
    " Assign 0 to disable plug option
    ```
- Detect using neovim or not (automatic detection)
    - Neovim is better for loading tons of plugins
    - Neovim configuration path is different from vim
    ```vim
    " Use vim or neovim (Auto-detect)
    let USING_NEOVIM = has('nvim')
    let USING_VIM = !USING_NEOVIM
    ```
- Check if using vim 8.0 or higher
    - If vim version is less than 8.0, some function is not available (e.g. terminal)
    - Required for
        - [Built-in] terminal mode
        - [Plug-in] vim-polyglot (multi-language support)
        - [Plug-in] ale (multi-languages syntax highlight)
    ```vim
    " Check if vim version >= 8.0 (also for neovim >= 0.5)
    let USING_VIM8 = 1
    ```
- Customize vim color scheme
    - For fancy symbol support, nerd font is needed (check https://github.com/ryanoasis/nerd-fonts )
    - For pywal theme support, pywal is needed (check https://github.com/dylanaraps/pywal ),
      also remember to change the directory path to your $HOME/.cache/wal
    ```vim
    " Customize vim theme (Include colorscheme and statusline)
    let USING_CUSTOMIZED_THEME = 1
    " Fancy symbols (Mainly affect lightline and nerdtree icon)
    let USING_FANCY_SYMBOLS = 1
    " Wal theme support (Xresources colortheme support, check pywal)
    "let USING_WAL_THEME = isdirectory('/home/jordankhwu/.cache/wal')
    let USING_WAL_THEME = 0
    ```
- Extra vim-plug
    - Extra plug for productivity (or enhance vim-built in function)
    - Including
        - [Plug-in] vim-startify (start page for empty buffer)
        - [Plug-in] goyo (distraction-free editor)
        - [Plug-in] limelight (light-off with goyo)
        - [Plug-in] yankring (clipboard history)
        - [Plug-in] vim-peekaboo (vim register viewer/manager)
        - [Plug-in] vim-markbar (vim mark viewer/manager)
        - [Plug-in] vim-easymotion (physical movement)
        - [Plug-in] AutoComplPop (auto completion pop-up)
        - [Plug-in] FixedTaskList (find TODO tag in vim)
        - [Plug-in] vim-hexokinase (hex color code color highlight support)
    ```vim
    " Extra vim-plug (Include easymotion, yankring, autocolpop, and etc.)
    let USING_EXTRA_PLUG = 1
    ```
- Coding tool vim-plug
    - Tools for coding, git, language syntax highlight
    - Including
        - [Plug-in] vim-polyglot (multi-language support)
        - [Plug-in] ale (multi-language syntax highlight)
        - [Plug-in] neoformat (code formatter)
        - [Plug-in] rainbow (pair bracket highlight)
        - [Plug-in] indentLine (indent line indicator)
        - [Plug-in] vim-indent-guides (indent highlight)
        - [Plug-in] vim-indent-object (add indent object to vim)
        - [Plug-in] vim-multiple-cursors (multiple cursors)
        - [Plug-in] vim-fugitive (git toolbox)
        - [Plug-in] vim-gitgutter (git diff highlight)
    ```vim
    " Coding tools vim-plug (Include syntax support, git function, and etc.)
    let USING_CODING_TOOL_PLUG = 1
    ```
- Python completion vim-plug
    - Tools for python completion
    - Requirements must be satisfied (check python completion preparation at the first session)
    - Including
        - [Plug-in] nvim-yarp (yet another remote plugin framework for neovim)
        - [Plug-in] vim-hug-neovim-rpc (plugin bridge from neovim to vim)
        - [Plug-in] deoplete-jedi (python completion)
        - [Plug-in] jedi-vim (definition and feature finder)
    ```vim
    " Python Completion (Use deoplete and jedi, neovim is recommended to be used)
    let USING_PYTHON_COMPLETION = 1
    " Python that used to install jedi, pynvim and python packages for completion
    let PYTHON_FOR_COMPLETION = '/home/jordankhwu/anaconda3/bin/python'
    ```
- GUI support
    - Functions for external GUI software
    - Requires
        - Latex previewer
        - Markdown previewer
    ```vim
    " Support of external GUI software (e.g. Okular, Google-chrome, and etc.)
    let USING_GUI_SOFTWARE = 1
    " Web browser for markdown preview
    let WEBBROWSER = 'brave-browser'
    ```

</details>

### Section 4 - Key Mapping (Vim)
<details>
<summary>Click to expand!</summary>

#### Key Mapping - Customized Key Mapping Rule (Vim)
<details open>
<summary>Click to expand!</summary>

> _1. Key Mapping should not be much different from the original VIM_
- To make life easier instead of filled up with bloated key mapping
> _2. Every function (motion) should start with a leader key for most of time_
- To prevent conflict with built-in hotkey or other program hotkeys
- In this configuration, leader key is __SPACE__ key
> 3. _Key mapping should be related to the name of the function_
- Make it easier to remember or connect
- e.g. "no wrap" function is mapped to `[Space]`+`[w]`+`[p]`

</details>

#### Key Mapping Sheet 1 - Fn Key Key Mapping (Vim)
<details>
<summary>Click to expand!</summary>

1. Function Key Key Mapping

| VIM-Mode | Key Mapping      | Function                        | Description                      | Note                                                    |
| :------: | :--------------: | :-----------------------------: | :------------------------------: | :-----------------------------------------------------: |
| N/V      | (`[LK]`)+`[F1]`  | (Previous)/Next Buffer          | Switch between buffers           |                                                         |
| N/V      | (`[LK]`)+`[F2]`  | (Previous)/Next Tab             | Switch between tabs              |                                                         |
| N/V      | `[F3]`           | Nerdtree current file           | Show current file location       |                                                         |
| N/V      | `[LK]`+`[F3]`    | Toggle Nerdtree                 | On/Off NerdTree plugin           |                                                         |
| N/V      | `[F4]`           | Markdown/Latex previewer        | Open external Viewer             | Only for .md or .tex file                               |
| N/V      | `[LK]`+`[F4]`    | Toggle Tagbar                   | On/Off Tagbar plugin             |                                                         |
| N/V      | (`[LK]`)+`[F5]`  | Toggle (Rel)/Abs line number    | On/Off rel/abs line number       |                                                         |
| N/V      | `[F6]`           | Toggle fold column (short-4)    | On/Off fold column (short-4)     | For easier code fold visualization                      |
| N/V      | `[LK]`+`[F6]`    | Toggle fold column (long-8)     | On/Off fold column (long-8)      | For easier code fold visualization                      |
| N/V      | `[F7]`           | Toggle show line border         | On/Off highlight 79th character  | VIM recommends at most 78 characters for one line       |
| N/V      | `[LK]`+`[F7]`    | Toggle show line border         | On/Off highlight 79th column     | VIM recommends at most 78 characters for one line       |
| N/V      | `[F8]`           | Toggle highlight comment        | On/Off highlight code comment    | Assign brighter color to comment to highlight it        |
| N/V      | `[LK]`+`[F8]`    | Toggle highlight fold           | On/Off highlight  vim fold       | Assign brighter color to comment to highlight it        |
| N/V      | `[F9]`           | Toggle indent highlight (line)  | On/Off indent highlight (line)   |                                                         |
| N/V      | `[LK]`+`[F9]`    | Toggle indent highlight (block) | On/Off indent highlight (block)  |                                                         |
| N/V      | (`[LK]`)+`[F10]` | (Load)/Save vim layout          | Load/Save vim layout             | Including pane split, folds, and etc.                   |
| N/V      | (`[LK]`)+`[F11]` | (Off)/On synchronized cursor    | Off/On synchronized cursor       | Need to execute in every pane that wants to synchronize |
| N/V      | (`[LK]`)+`[F12]` | (Exit)/Enter terminal mode      | Exit/Enter terminal mode         |                                                         |

</details>

#### Key Mapping Sheet 2 - Built-in Function Key Mapping (Vim)
<details>
<summary>Click to expand!</summary>

1. Buffer/Tab Key Mapping

| VIM-Mode | Key Mapping              | Function               | Description            | Note |
| :------: | :----------------------: | :--------------------: | :--------------------: | :--: |
| N/V      | `[LK]`+`[b]`+`[b]`       | Add new buffer         | Add new buffer         |      |
| N/V      | `[LK]`+`[b]`+`[d]`+`[d]` | Close current buffer   | Close current buffer   |      |
| N/V      | `[LK]`+`[Shift]`+`[j/k]` | Go to next/prev buffer | Go to next/prev buffer |      |
| N/V      | `[LK]`+`[t]`+`[t]`       | Add new tab            | Add new tab            |      |
| N/V      | `[LK]`+`[t]`+`[d]`+`[d]` | Close current tab      | Close current tab      |      |
| N/V      | `[LK]`+`[Shift]`+`[l/h]` | Go to next/prev tab    | Go to next/prev tab    |      |
| N/V      | `[LK]`+`[Shift]`+`[./,]` | Move tab to next/prev  | Move tab to next/prev  |      |

2. Split/Window Key Mapping

| VIM-Mode | Key Mapping                          | Function                          | Description                        | Note                                                            |
| :------: | :----------------------------------: | :-------------------------------: | :--------------------------------: | :-------------------------------------------------------------: |
| N/V      | `[Ctrl]`+`[w]`+`[s/v]`               | Add new split Horizontal/Vertical | Add new split Horizontal/Vertical  |                                                                 |
| N/V      | `[Ctrl]`+`[h/j/k/l]`                 | Move between vim splits           | Move between splits (L/D/U/R)      | With plugin, you can even move between TMUX pane and VIM splits |
| N/V      | `[Ctrl]`+`[w]`+`[h/j/k/l]`           | Move between vim splits           | Move between splits (L/D/U/R)      |                                                                 |
| N/V      | `[Ctrl]`+`[w]`+`[Shift]`+`[h/j/k/l]` | Move current split (L/D/U/R)      | Move current split (L/D/U/R)       |                                                                 |
| N/V      | `[Alt]`+`[h/j/k/l]`                  | Resize current split size         | Resize current split size          |                                                                 |
| N/V      | `[Ctrl]`+`[w]`+`[=]`                 | Re-split splits equally           | Re-split splits equally            | Here =(equal sign) for equally split                            |
| N/V      | `[LK]`+`[r]`+`[1/2]`                 | Resize current split to 10/20rows | Resize current split to 10/20 rows | For terminal pane resize                                        |

3. Code Folding Key Mapping

| VIM-Mode | Key Mapping             | Function                     | Description                              | Note         |
| :------: | :---------------------: | :--------------------------: | :--------------------------------------: | :----------: |
| N/V      | (`[LK]`)+`[F10]`        | Load/Save layout and folding | Load/Save current split and code folding |              |
| N/V      | `[z]`+`[k/j]`           | Go to Prev/Next folding      | Go to Prev/Next folding                  | Vim built-in |
| N/V      | `[z]`+`[o/c]`           | Open/Close current folding   | Open/Close current folding               | Vim built-in |
| N/V      | `[z]`+`[Shift]`+`[r/m]` | Show/Close all foldings      | Show/Close all foldings                  | Vim built-in |
| V        | `[Shift]`+`[k/j]`       | Move selection block up/down | Move selection block up/down             |              |

4. Diff Mode Key Mapping

| VIM-Mode | Key Mapping          | Function                           | Description                        | Note                                        |
| :------: | :------------------: | :--------------------------------: | :--------------------------------: | :-----------------------------------------: |
| N/V      | `[LK]`+`[d]`+`[s/v]` | Add diff split Horizontal/Vertical | Add diff split Horizontal/Vertical |                                             |
| N/V      | `[Lk]`+`[d]`+`[j/k]` | Jump to next/prev diff             | Jump to next/prev diff             |                                             |
| N/V      | `[Lk]`+`[d]`+`[g]`   | Get diff from neighbor pane        | Get diff from neighbor pane        | Recommend to use with visual mode selection |
| N/V      | `[Lk]`+`[d]`+`[p]`   | Put diff to neighbor pane          | Put diff to neighbor pane          | Recommend to use with visual mode selection |
| N/V      | `[Lk]`+`[d]`+`[u]`   | Update diff                        | Update diff                        |                                             |

5. Spell Mode Key Mapping

| VIM-Mode | Key Mapping              | Function                                   | Description                                | Note                              |
| :------: | :----------------------: | :----------------------------------------: | :----------------------------------------: | :-------------------------------: |
| N/V      | `[LK]`+`[s]`             | Toggle spell mode                          | Toggle spell mode                          | Here s for (s)pell                |
| N/V      | `[LK]`+`[s]`+`[j/k]`     | Jump to prev/next bad word                 | Jump to pre/next bad word                  |                                   |
| N/V      | `[LK]`+`[s]`+`[a]`+`[g]` | Add word to good word list spell mode      | Add word to good word list spell mode      | Here a for (a)dd, g for (g)ood    |
| N/V      | `[LK]`+`[s]`+`[r]`+`[g]` | Remove word from good word list spell mode | Remove word from good word list spell mode | Here r for (r)emove, g for (g)ood |
| N/V      | `[LK]`+`[s]`+`[a]`+`[b]` | Add word to bad word list spell mode       | Add word to bad word list spell mode       | Here a for (a)dd, b for (b)ad     |
| N/V      | `[LK]`+`[s]`+`[r]`+`[b]` | Remove word from bad word list spell mode  | Remove word from bad word list spell mode  | Here r for (r)emove, b for (b)ad  |


6. Miscellaneous Function Key Mapping

| VIM-Mode | Key Mapping           | Function                          | Description                       | Note                                            |
| :------: | :-------------------: | :-------------------------------: | :-------------------------------: | :---------------------------------------------: |
| I        | `[k]`+`[j]`           | Esc (escape form insert mode)     | Esc (escape form insert mode)     |                                                 |
| N/V      | `[Shift]`+`[k]`       | Search current word in manual     | Search current word in manual     |                                                 |
| N/V      | `[LK]`+`[d]`+`[d]`    | Close current buffer              | Close current buffer              | Here d for (d)eletion                           |
| N/V      | `[LK]`+`[w]`+`[p]`    | Toggle line wrap                  | On/Off line wrap                  | Here wp for (w)ra(p)                            |
| N/V      | `[LK]`+`[s]`+`[t]`    | Toggle list (trailing chars)      | On/Off list (trailing characters) | Here st for li(s)(t)                            |
| N/V      | `[LK]`+`[/]`          | Toggle search highlight           | On/Off search highlight           |                                                 |
| N/V      | `[LK]`+`[m]`+`[k]`    | Show all vim marks                | Show all vim marks                | This shows marks using fzf instead vim built-in |
| N/V      | `[LK]`+`[r]`+`[g]`    | Show all vim registers            | Show all vim registers            | Here re for (re)gister                          |
| N/V      | `[LK]`+`[a]`+`[b]`    | Show all vim abbreviates          | Show all vim abbreviates          | Here ab for (ab)reviation                       |
| N/V      | `[LK]`+`[c]`+`[h/v]`  | Toggle Horizontal/Vertical cursor | On/Off Horizontal/Vertical cursor |                                                 |
| N/V      | `[LK]`+`[g]`+`[o/i]`  | Show all cursor jump              | Show all cursor jump              | `[g/Ctrl]`+`[o/i]` jump backwards/forwards      |
| N/V      | `[LK]`+`[g]`+`[;/,]`  | Show all file change              | Show all file change              | `[g]`+`[;/,]` go to earlier/later change        |

</details>

#### Key Mapping Sheet 3 - Plug-in Function Key Mapping (Vim)
<details>
<summary>Click to expand!</summary>

1. File/Code Browsing Key Mapping
- Note: Fzf is needed for file browsing

| VIM-Mode | Key Mapping                     | Function                              | Description                           | Note                       |
| :------: | :-----------------------------: | :-----------------------------------: | :-----------------------------------: | :------------------------: |
| N/V      | `[F3]`                          | Nerdtree Current Files                | Show current file location            |                            |
| N/V      | `[LK]`+`[F3]`                   | Toggle Nerdtree                       | On/Off NerdTree plugin                |                            |
| N        | `[s/v]`                         | Open file in split/vsplit pane        | Open file in split/vsplit pane        | In NERDTree pane           |
| N        | `[g]`+`[s/v]`                   | Preview file in split/vsplit pane     | Preview file in split/vsplit pane     | In NERDTree pane           |
| N        | `[c]`+`[d]`                     | Change pwd to selected location       | Change pwd to selected location       | In NERDTree pane           |
| N        | `[Shift]`+`[c]`+`[Shift]`+`[d]` | Change tree root to selected location | Change tree root to selected location | In NERDTree pane           |
| N/V      | `[LK]`+`[F4]`                   | Toggle Tagbar                         | On/Off Tagbar plugin                  |                            |
| N        | `[LK]`+`[f]`+`[f]`+`[s]`        | List files under input directory      | List files under input directory      |                            |
| N        | `[LK]`+`[f]`+`[l]`+`[c]`        | Locate files matched input            | Locate files matched input name       | Use system locate command  |
| N        | `[LK]`+`[f]`+`[r]`+`[g]`        | Find files with input pattern         | Find files matched input pattern      | Use system ripgrep command |
| N        | `[LK]`+`[f]`+`[f]`+`[t]`        | Select file type for current          | Select file type for current file     |                            |
| N        | `[LK]`+`[f]`+`[c]`+`[d]`        | Show all command in vim now　         | Show all command in vim now           | 　                         |
| N        | `[LK]`+`[f]`+`[n]`+`[m]`        | Show all normal mode mapping          | Show all normal mode mapping          |                            |
| N        | `[LK]`+`[f]`+`[h]`+`[t]`        | Show all helptags in vim-help         | Show all helptags in vim-help         |                            |

2. Python Coding Key Mapping
- Note: Jedi is needed for python code analysis (Check https://github.com/davidhalter/jedi )
- Note: All below functions only work in .py files

| VIM-Mode | Key Mapping                  | Function                      | Description                       | Note                        |
| :------: | :--------------------------: | :---------------------------: | :-------------------------------: | :-------------------------: |
| N/V      | `[Shift]`+`[k]`              | Search current word in doc    | Search current word in python doc |                             |
| N/V      | `[LK]`+`[p]`+`[n]`           | Find current word occurrences | Find current word occurrences     | Here p for (p)ython         |
| N/V      | `[LK]`+`[p]`+`[a]`           | Find current word assignment  | Find current word assignment      |                             |
| N/V      | `[LK]`+`[p]`+`[d]`           | Show current word definition  | Show current word definition      |                             |
| N/V      | `[LK]`+`[p]`+`[m]`           | Show current word init.py     | Show current word init.py         |                             |
| N/V      | `[LK]`+`[p]`+`[Shift]`+`[m]` | Show input module init.py     | Show input module init.py         |                             |
| N        | `[LK]`+`[p]`+`[i]`           | Run isort formatter           | Run isort formatter (modules)     | isort needs to be installed |
| N        | `[LK]`+`[p]`+`[y]`           | Run yapf formatter            | Run yapf formatter (PEP8)         | yapf needs to be installed  |

3. Miscellaneous Function Key Mapping
- Useful tool (Note: startup by default)

| VIM-Mode | Key Mapping                   | Function                        | Description                           | Note                      |
| :------: | :---------------------------: | :-----------------------------: | :-----------------------------------: | :-----------------------: |
| N/V      | `[LK]`+`[c]`+`[c/y]`          | Comment (and copy) current line | Comment (and copy) current line       | NerdCommenter             |
| N/V      | `[LK]`+`[c]`+`[u]`            | Uncomment current line          | Uncomment current line                | NerdCommenter             |
| N/V      | `[LK]`+`[Backtick]`           | Select vim pane                 | Select vim pane in tabs and splits    | vim-choosewin             |
| N/V      | `[LK]`+`[z]`                  | Toggle maximize current split   | On/Off maximize current split         | vim-maximizer             |
| N/V      | `[Ctrl]`+`[w]`+`[z]`          | Toggle maximize current split   | On/Off maximize current split         | vim-maximizer             |
| N/V      | `[y]`+`[s]`+`[a]`+`[w]`+`["]` | Add wrapped quotation/bracket   | From word to "word"                   | vim-surrounder            |
| N/V      | `[d]`+`[s]`+`[a]`+`[w]`+`["]` | Del wrapped quotation/bracket   | From "word" to word                   | vim-surrounder            |
| N/V      | `[c]`+`[s]`+`[']`+`["]`       | Change quotation/bracket        | From 'word' to "word"                 | vim-surrounder            |
| N/V/I    | `[LK]`+`[Enter]`              | Toggle auto-completion pop-up   | On/Off auto-completion pop-up         | autocomplpop              |
| N/V/I    | `[Alt]`+`[']`                 | Toggle auto-pair                | On/Off auto-pair quotation/bracket    | auto-pairs                |
| N/V/I    | `[Alt]`+`[;]`                 | Jump to next pairs              | Jump to next paired quotation/bracket | auto-pairs                |
| I        | `[Alt]`+`[w]`                 | Auto-pair fastwrap              | Auto-pair fastwrap current pairs      | Example: ()test -> (test) |
| N        | `[LK]`+`[v]`+`[w]`            | Open vimwiki index page         | Open vimwiki index page               | vimwiki                   |
| N        | `[LK]`+`[v]`+`[i]`            | Open vimwiki diary index page   | Open vimwiki diary index page         | vimwiki                   |

- Extra plug (Note: "let using_extra_plug = 1" must be set in vimrc)

| VIM-Mode | Key Mapping          | Function                     | Description                  | Note           |
| :------: | :------------------: | :--------------------------: | :--------------------------: | :------------: |
| N/V      | `[LK]`+`[h/j/k/l]`   | Quick move in four direction | Quick move in four direction | vim-easymotion |
| N/V      | `[LK]`+`[y]`+`[s]`   | Show yank history            | Show yank history            | yankring       |
| N/V      | `[y]`+`[n/p]`        | Paste next/prev clipped item | Paste next/prev clipped item | yankring       |
| N/V      | `[LK]`+`[g]`+`[y]`   | Distraction-free mode        | Distraction-free mode        | goyo           |

- Coding tool (Note: "let using_coding_tool_plug = 1" must be set in vimrc)

| VIM-Mode | Key Mapping                           | Function                        | Description                                        | Note                                                          |
| :------: | :-----------------------------------: | :-----------------------------: | :------------------------------------------------: | :-----------------------------------------------------------: |
| N/V      | `[Alt]`+`[n]` (+`[n]`+`[n]`+...+`[n]` | Multiple cursor for selected    | Multiple cursor for currently selected word        | Press N to next word; Use I/A to insert word; Use Esc to exit |
| N/V      | `[Alt]`+`[p]` (+`[p]`+`[p]`+...+`[p]` | Cancel selected multiple cursor | Cancel selected multiple cursor                    |                                                               |
| N/V      | `[Alt]`+`[o]` (+`[o]`+`[o]`+...+`[o]` | Omit selected multiple cursor   | Omit selected multiple cursor                      |                                                               |
| N/V      | `[LK]`+`[a]`+`[l]`                    | Toggle ALE                      | On/Off ALE                                         | Enabled at startup                                            |
| N/V      | `[LK]`+`[a]`+`[j/k]`                  | Go to Next/Prev ALE linter      | Go to Next/Prev ALE linter                         |                                                               |
| N/V      | `[LK]`+`[g]`+`[g]`                    | Toggle GitGutter                | On/Off GitGutter                                   | Disabled at startup                                           |
| N/V      | `[LK]`+`[g]`+`[h]`+`[s/l/n]`          | Toggle GitGutter highlight      | Toggle GitGutter highlight symbol/line/line number |                                                               |
| N/V      | `[LK]`+`[g]`+`[j/k]`                  | Go to Next/Prev git hunks       | Go to Next/Prev git hunks                          | Hunk means changed block                                      |
| N/V      | `[LK]`+`[g]`+`[Shift]`+`[p]`          | Hunk preview (before changed)   | Hunk preview (before changed)                      | Here p for (p)review                                          |
| N/V      | `[LK]`+`[g]`+`[Shift]`+`[f]`          | Fold all unchanged lines        | Fold all unchanged lines                           |                                                               |
| N/V      | `[LK]`+`[g]`+`[Shift]`+`[s]`          | Stage current hunk              | Stage current hunk                                 | Here s for (s)tage                                            |
| N/V      | `[LK]`+`[g]`+`[Shift]`+`[u]`          | Restore current hunk            | Restore current hunk                               | Like vim undo                                                 |
| N/V      | `[LK]`+`[g]`+`[s]`                    | Summary of current git repo     | Summary of current git repo                        | Here s for (s)ummary                                          |
| N/V      | `[LK]`+`[g]`+(`[Shift]`)+`[d]`        | Git diff (all unstaged files)   | Git diff (all unstaged files)                      |                                                               |
| N/V      | `[LK]`+`[g]`+(`[Shift]`)+`[a]`        | Git add (all unstaged files)    | Git add (all unstaged files)                       |                                                               |
| N/V      | `[LK]`+`[g]`+(`[Shift]`)+`[c]`        | Git commit all staged files     | Git commit all staged files)                       |                                                               |
| N/V      | `[LK]`+`[g]`+`[Shift]`+`[b]`          | Git blame current file          | Git blame current file                             |                                                               |

</details>

#### Key Mapping Sheet 4 - Vim Whichkey (Vim)
<details>
<summary>Click to expand!</summary>

- Most leader key related key mapping is mapped by which-key plugins which will show useful hints when leader key
and following keys are pressed. Table below includes some frequently used key mappings.

| `[LK]` + | Function    | Description     |
| :------: | :---------: | :-------------: |
| `a`      | Ale         | Linter          |
| `b`      | Buffer      | Built-in buffer |
| `c`      | Commenter   | Commenter       |
| `d`      | Diff        | Built-in diff   |
| `f`      | Fzf         | File-browser    |
| `g`      | Git         |                 |
| `m`      | Mark/Manual | Built-in mark   |
| `p`      | Python      |                 |
| `s`      | Spell       | Built-in spell  |
| `t`      | Tab         | Built-in tab    |
| `v`      | Vim-wiki    | Note-taking     |
| `y`      | Yank        | Yank manager    |
| `s`+`l`  | Statusline  | Status line     |
| `c`+`s`  | Colorscheme | Color scheme    |

</details>
</details>

### Reference for Setup (Vim)
<details>
<summary>Click to expand!</summary>

- http://fisadev.github.io/fisa-vim-config/
- http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
- https://github.com/ryanoasis/nerd-fonts/
- https://github.com/sbdchd/Neoformat
- https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
- https://vim.wikia.com/wiki/Disable_beeping
- https://blog.gtwang.org/useful-tools/how-to-use-vim-as-a-hex-editor/
- https://github.com/junegunn/vim-plug
- https://krehwell.com/blog/Open%20Markdown%20Previewer%20Through%20Vim
- https://github.com/shengjunlin/vimrc
- http://nadypan.blogspot.com/2014/01/vim-fold.html
- https://github.com/yangyangwithgnu/use_vim_as_ide
- https://factorpad.com/tech/vim-cheat-sheet.html#structure
- https://github.com/wsdjeg/vim-galore-zh_cn
- https://github.com/mhinz/vim-galore
- https://ahuigo.github.io/b/vim/vim-var#/
- https://learnvimscriptthehardway.stevelosh.com/chapters/24.html

</details>
</details>

## Part 2 - TMUX
<details open>
<summary>Click to expand!</summary>

### Section 1 - What's New in My Customization (TMUX)
<details open>
<summary>Click to expand!</summary>

> 1. Bindkey is remapped from "Ctrl+b" to **_"Ctrl+a"_** (primary) and **_"Ctrl+Space"_** (secondary)
> 2. Commands related to pane and split are remapped to my **_vim-like key mapping_** to keep things consistent
> 3. Add **_new status line theme_** to make press of bindkey more eye-catching
> 4. Add **_clipboard sharing_** between vim, system, and TMUX (through xclip)

</details>

### Section 2 - First Time Usage (TMUX)
<details>
<summary>Click to expand!</summary>

#### 1. Preparation for Dependence (TMUX)

1. Common Requirement
- __Git__ [for TMUX plugin manager setup]
```bash
# For Fedora
dnf install git
```
- __Powerline__ [powerline support for TMUX status line ]
```bash
# For Fedora
dnf install powerline
dnf install tmux-powerline
```

#### 2. Copy Configuration File (TMUX)
- version >= __2.0__
```bash
# Check TMUX version
tmux -V
```

1. Copy Configuration File
- __TMUX__
    1. copy "tmux.conf" to $HOME (current user's home)
    2. rename "tmux.conf" to .tmux.conf
    ```bash
    cp tmux.conf $HOME/.tmux.conf
    ```

#### 3. First Time Startup (TMUX)
- At first time startup, we need to install TMUX plugin manager, load configuration file and install plugins
    1. TMUX plugin manager (TPM) installation
    ```bash
    # In terminal
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    ```
    2. Load configuration file
    ```bash
    # Open TMUX in terminal
    tmux
    # In TMUX, press ctrl+b to enter command mode
    # In command mode
    source-file ~/.tmux.conf
    ```
    3. Install plugins
        - Press "Ctrl+Space", then "I"
        - Plugin manager should start installation automatically

</details>

### Section 3 - Plugin Usage (TMUX)
<details>
<summary>Click to expand!</summary>

#### Installed Plugins (TMUX)
- [Plug-in] tmux-prefix-highlight (prefix/mode indicator for status line)
- [Plug-in] tmux-pop (flash when change focus to different pane)
- [Plug-in] tmux-sidebar (nerdtree-like file tree for TMUX)
- [Plug-in] tmux-sessionist (make create/kill session ability easier to use)
- [Plug-in] tmux-resurrect (save TMUX layout, and restore after restart TMUX)
- [Plug-in] tmux-continuum (auto-save, auto-load for tmux-resurrect)
- [Plug-in] vim-tmux-navigator (move between vim and tmux pane seamlessly)
- [Plug-in] tmux-copycat (enhanced TMUX search)
- [Plug-in] tmux-yank (share TMUX clipboard with system clipboard)
- [Plug-in] tmux-open (open TMUX context easily in TMUX copy mode)
- [Plug-in] tmux-logging (logging and screen capturing for TMUX)

</details>

### Section 4 - Key Mapping (TMUX)
<details>
<summary>Click to expand!</summary>

#### Key Mapping - Customized Key Mapping Rule (TMUX)
<details open>
<summary>Click to expand!</summary>

> _1. Key mapping should not be much different from the original TMUX_
- To make life easier instead of filled up with bloated key mapping
> _2. Key mapping should start with bindkey_
- Though more keys is needed, but this can prevent key conflict with other applications
> _3. Window related operations should be mapped related to `[Shift]`+`[']`_
- To make it consistent within TMUX
> _4. Session related operations should be mapped related to `[Alt]`+`[']`_
- To make it consistent within TMUX

</details>

#### Key Mapping Sheet 1 - Session/Window/Pane Key Mapping (TMUX)
- Session

| TMUX-Mode | Key Mapping               | Function                   | Description               | Note                                                   |
| :-------: | :-----------------------: | :------------------------: | :-----------------------: | :----------------------------------------------------: |
| Normal    | `[BK]`+`[Shift]`+`[4]`    | Rename current session     | Rename current session    | `[$]`                                                  |
| Normal    | `[BK]`+`[s]`              | Show all TMUX sessions     | Show all TMUX sessions    |                                                        |
| Normal    | `[BK]`+`[Alt`+`[c]`       | Create new session         | Create new session        | tmux-sessionist                                        |
| Normal    | `[BK]`+`[Alt]`+`[x]`      | Kill current session       | Kill current session      | tmux-sessionist; Default key is `[BK]`+`[&]`           |
| Normal    | `[BK]`+`[Shift]`+`[9/0]`  | Move to prev/next session  | Move to prev/next session | `(` / `)`                                              |
| Normal    | `[BK]`+`[Alt]`+`[Escape]` | Switch to last session     | Switch to last session    | tmux-sesionist; Default key is `[BK]`+`[Shift]`+`[l]`  |
| Normal    | `[BK]`+`[k/j]`            | Move to prev/next session  | Move to prev/next session |                                                        |

- Window

| TMUX-Mode | Key Mapping                   | Function                         | Description                     | Note                        |
| :-------: | :---------------------------: | :------------------------------: | :-----------------------------: | :-------------------------: |
| Normal    | `[BK]`+`[Number]`             | Move to window (number)          | Move to window (number)         |                             |
| Normal    | `[BK]`+`["]`                  | Move to window index             | Move to window index            | Default key is `[BK]`+`[']` |
| Normal    | `[BK]`+`[,]`                  | Rename current window            | Rename current session          |                             |
| Normal    | `[BK]`+`[w]`                  | Show all windows                 | Show all windows                |                             |
| Normal    | `[BK]`+`[Shift]`+`[c]`        | Create new window                | Create new window               | Default key is `[BK]`+`[c]` |
| Normal    | `[BK]`+`[Shift]`+`[x/7]`      | Kill current window              | Kill current window             |                             |
| Normal    | `[BK]`+`[Shift]`+`[Backtick]` | Switch to last window            | Switch to last window           | Default key is `[BK]`+`[l]` |
| Normal    | `[BK]`+`[h/l]`                | Move to next/prev window         | Move to next/prev window        |                             |
| Normal    | `[BK]`+`[Shift]`+`[h/l]`      | Swap window to prev/next window  | Swap window to prev/next window |                             |

- Pane

| TMUX-Mode | Key Mapping                | Function                            | Description                           | Note                                           |
| :-------: | :------------------------: | :---------------------------------: | :-----------------------------------: | :--------------------------------------------: |
| Normal    | `[BK]`+`[Tab]`             | Show all panes                      | Show all panes                        |                                                |
| Normal    | `[BK]`+`[Shift]`+`[-]`     | Split pane vertically               | Split pane vertically                 | Default key is `[BK]`+`[Shift]`+`[']` (`["]`)  |
| Normal    | `[BK]`+`[Shift]`+`[\]`     | Split pane horizontally             | Split pane horizontally               | Default key is `[BK]`+`[Shift]`+`[5]` (`[%]`)  |
| Normal    | `[BK]`+`[q/']`             | Move to pane (number)               | Move to pane (number)                 | Pane number shows on pane                      |
| Normal    | `[Ctrl]`+`[h/j/k/l]`       | Move to pane (L/D/U/R)              | Move to pane (L/D/U/R)                | vim-tmux-navigator                             |
| Normal    | `[BK]`+`[n/p]`             | Move to pane next/previous          | Move to pane next/previous            | Default key is `[BK]`+`[n/p]` next/prev window |
| Normal    | `[BK]`+`[Backtick]`        | Switch to last pane                 | Switch to last pane                   | Default key is `[BK]`+`[;]`                    |
| Normal    | `[BK]`+`[Shift]`+`[j/k]`   | Swap pane to prev/next pane         | Swap pane to prev/next pane           |                                                |
| Normal    | `[BK]`+`[Shift]`+`[n/p]`   | Rotate pane anti-clock/clock wisely | Rotate pane (anti-clock/clock)wisely  | Default key is `[BK]`+`[Ctrl/Alt]`+`[o]`       |
| Normal    | `[BK]`+`[Space]`           | Toggle pane layout                  | Toggle pane layout                    |                                                |
| Normal    | `[BK]`+`[Alt]`+`[h/j/k/l]` | Resize pane to (L/D/U/R)            | Resize pane to (L/D/U/R)              |                                                |

#### Key Mapping Sheet 2 - Copy-mode Key Mapping (TMUX)

| TMUX-Mode | Key Mapping            | Function                      | Description                   | Note                |
| :-------: | :--------------------: | :---------------------------: | :---------------------------: | :-----------------: |
| Normal    | `[BK]`+`[;]`           | Enter copy mode               | Enter copy mode               |                     |
| Normal    | `[BK]`+`[]]`           | Paste selected contents       | Paste selected contents       |                     |
| Normal    | `[BK]`+`[Shift]`+`[3]` | Show all buffer list          | Show all buffer list          | `[#]`               |
| Normal    | `[BK]`+`[=]`           | Paste from buffer list        | Paste from buffer list        |                     |
| Normal    | `[BK]`+`[/]`           | Search and select pattern     | Search and select pattern     | tmux-copy-cat       |
| Normal    | `[BK]`+`[Shift]`+`[t]` | Show time in copy mode        | Show time in copy mode        |                     |
| Copy      | `[v/Space]`            | Start selection               | Start selection               | TMUX built-in clock |
| Copy      | `[Ctrl]`+`[v]`         | Vim-like block selection      | Vim-like block selection      |                     |
| Copy      | `[Shift]`+`[v]`        | Vim-like line selection       | Vim-like line selection       |                     |
| Copy      | `[y]`                  | Vim-like yank selected region | Vim-like yank selected region |                     |
| Copy      | `[;/q/Enter]`          | Quit copy mode                | Quit copy mode                |                     |

#### Key Mapping Sheet 3 - Miscellaneous (TMUX)

| TMUX-Mode | Key Mapping                    | Function                            | Description                        | Note                                              |
| :-------: | :----------------------------: | :---------------------------------: | :--------------------------------: | :-----------------------------------------------: |
| Normal    | `[BK]`+`[Shift]`+`[/]`         | Show all TMUX key mapping           | Show all TMUX key mapping          |                                                   |
| Normal    | `[BK]`+`[Shift]`+`[b]`         | Toggle TMUX status line             | Toggle TMUX status line            |                                                   |
| Normal    | `[BK]`+`[b]`                   | Toggle TMUX borderline              | Toggle TMUX borderline             |                                                   |
| Normal    | `[BK]`+`[Shift]`+`[r]`         | Reload TMUX configuration           | Reload TMUX configuration          | Run source `$HOME/.tmux.conf` file                |
| Normal    | `[BK]`+`[F3]`                  | Sidebar file-tree                   | Sidebar file-tree                  | tmux-sidebar                                      |
| Normal    | `[BK]`+`[Alt]`+`[s/r]`         | Save/Load current session           | Save/Load current session          | tmux-resurrect                                    |
| Normal    | `[BK]`+`[a]`                   | Clear terminal output               | Clear terminal output              | Act like Ctrl-l in terminal                       |
| Normal    | `[BK]`+`[Ctrl]`+`[h]`          | Send Ctrl+h to terminal             | Send Ctrl+h to terminal            | Ctrl+h is alternative backspace for fish shell    |
| Normal    | `[BK]`+`[Ctrl]`+`[k]`          | Send Ctrl+k to terminal             | Send Ctrl+k to terminal            | Ctrl+k is to delete to end of line for fish shell |
| Normal    | `[BK]`+`[Ctrl]`+`[l]`          | Send Ctrl+l to terminal             | Send Ctrl+l to terminal            | Ctrl+l is to clean screen for fish shell          |
| Normal    | `[BK]`+`[Ctrl]`+`[s]`          | Toggle pane synchronization         | Toggle pane synchronization        | Synchronize input for all panes                   |
| Normal    | `[BK]`+`[Shift]`+`[m]`         | Toggle mouse mode                   | Toggle mouse mode                  |                                                   |
| Copy      | `[BK]`+`[o]`                   | Open selected with system default   | Open selected with system default  | tmux-open, open with xdg-open                     |
| Copy      | `[BK]`+`[Ctrl]`+`[o]`          | Open selected with `$EDITOR`        | Open selected with `$EDITOR`       | tmux-open                                         |
| Normal    | `[BK]`+`[m]`                   | Mark current pane                   | Mark current pane                  | Mark pane for following usage                     |
| Normal    | `[BK]`+`[Shift]`+`[;]`         | Swap current pane with marked pane  | Swap current pane with marked pane | Target pane must be marked first                  |
| Normal    | `[BK]`+`[Alt]`+`[Shift]`+`[;]` | Move marked pane to current window  | Move marked pane to current window | Move (merge) marked pane to current window        |

</details>

### Reference for Setup (TMUX)
<details>
<summary>Click to expand!</summary>

- https://leanpub.com/the-tao-of-tmux/read#config
- https://github.com/powerline/powerline
- https://github.com/erikw/tmux-powerline
- https://github.com/tmux-plugins/tmux-resurrect
- https://github.com/tmux-plugins/tmux-sidebar
- https://github.com/tmux-plugins/tmux-yank
- https://github.com/tmux-plugins/tmux-logging
- https://github.com/tmux-plugins/tmux-copycat
- https://github.com/g6ai/dotfiles/tree/master/tmux
- https://danielmiessler.com/study/tmux/
- https://leimao.github.io/blog/Tmux-Tutorial/
- https://github.com/rothgar/awesome-tmux
- https://arcolinux.com/everything-you-need-to-know-about-tmux-status-bar/
- https://b9532026.wordpress.com/2020/12/01/%E5%BC%B7%E5%8C%96tmux%E6%93%8D%E4%BD%9C/
- https://github.com/tmux-plugins/tmux-prefix-highlight
- https://tao-of-tmux.readthedocs.io/zh_CN/latest/manuscript/09-status-bar.html
- https://gist.github.com/markandrewj/ead05ebc20f3968ec07e
- https://github.com/tmux-plugins/tpm

</details>
</details>
</details>
</details>
</details>
</details>
