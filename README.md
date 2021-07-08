# Vim_Tmux_Config
Backup for my vim and tmux configuration

Table of Contents
=================

* [Vim_Tmux_Config](#vim_tmux_config)
   * [Part 1 - Vim/Gvim/Neovim](#part-1---vimgvimneovim)
      * [Preparation (Dependence)](#preparation-dependence)
         * [1. Common Requirement](#1-common-requirement)
         * [2. Requirement for diverse vim](#2-requirement-for-diverse-vim)
      * [First Time Usage](#first-time-usage)
         * [1. Copy configuration file](#1-copy-configuration-file)
         * [2. First time startup (Vim/Gvim/Neovim)](#2-first-time-startup-vimgvimneovim)
      * [Plugins](#plugins)
         * [Plugin loading time](#plugin-loading-time)
         * [Plugin usage configuration (for more details, check sections in vimrc)](#plugin-usage-configuration-for-more-details-check-sections-in-vimrc)
      * [Keymapping - Customized Keymapping Rule](#keymapping---customized-keymapping-rule)
      * [Keymapping Sheet 1 - Fn Key Keymapping](#keymapping-sheet-1---fn-key-keymapping)
         * [Function Key Keymapping](#function-key-keymapping)
      * [Keymapping Sheet 2 - Built-in Function Keymapping](#keymapping-sheet-2---built-in-function-keymapping)
         * [1. Split/Window keymapping](#1-splitwindow-keymapping)
         * [2.Code Folding Keymapping](#2code-folding-keymapping)
         * [3.Miscellaneous Function Keymapping](#3miscellaneous-function-keymapping)
      * [Keymapping Sheet 3 - Plug-in Function Keymapping](#keymapping-sheet-3---plug-in-function-keymapping)
         * [File/Code Browsing Keymapping](#filecode-browsing-keymapping)
         * [Python Coding Keymapping](#python-coding-keymapping)
         * [Miscellaneous Function Keymapping](#miscellaneous-function-keymapping)
      * [Reference for VIM setup](#reference-for-vim-setup)

## Part 1 - Vim/Gvim/Neovim

### Preparation (Dependence)

#### 1. Common Requirement
- __Curl__ [for plugin manager setup]
    ```
    # For Fedora
    dnf install curl
    ```
- __Web browser with markdown plugin__ (e.g. google-chrome, firefox, and etc.) [for markdown preview]
    ```
    # For Fedora
    dnf install firefox
    ```
- __PDF viewer__ (e.g. okular) [for latex preview]
    ```
    # For Fedora
    dnf install okular
    ```

#### 2. Requirement for diverse vim
- __Vim__
    - version >= __7.0__
    - clipboard option is on (+clipboard) [for sharing system clipboard]
    - python3 option is on (+python3/dyn) [for python completion]
    ```
    # Check vim version and other options
    vim --version
    ```
- __Gvim__
    - version >= __7.0__
    - gvim already shipped with clipboard and python3 options
    ```
    # Check gvim version and other options
    vim --version
    ```
- __Neovim__
    - version >= __0.4__
    - neovim already shipped with clipboard and python3 options
    ```
    # Check nvim version and other options
    nvim --version
    ```

### First Time Usage

#### 1. Copy configuration file
- __Vim/Gvim__
    1. copy "vimrc" to $HOME (current user's home)
    2. rename "vimrc" to ".vimrc"
    ```
    cp vimrc $HOME/.vimrc
    ```
- __Neovim__
    1. copy "vimrc" to $HOME/.config/nvim (create one if not exists)
    2. rename "vimrc" to "init.vim"
    ```
    mkdir -p $HOME/nvim
    cp vimrc $HOME/nvim/init.vim
    ```

#### 2. First time startup (Vim/Gvim/Neovim)
- Following installation should start automatically at the first time startup
    1. vim-plug (plug manager) installation via __curl__
        - If not working, try manually install vim-plug (also within this repository)
            ```
            # For vim/gvim
            cp -r vim/autoload $HOME/.vim
            # For neovim
            cp -r vim/autoload $HOME/.config/nvim
            ```
    2. vim plugin installation via __vim-plug__
        - If not working, try manually install vim-Plug
            ```
            # In vim command line mode
            :Pluginstall
            ```

### Plugins
#### Plugin loading time
- Enable too much plugins may slow down your vim. you can check your loading time with following command
- For managing plugins enable/disable, see next section (Plugin usage configuration)
```
# For vim/gvim
vim --startuptime test.txt
# For neovim
nvim --startuptime test.txt
```

#### Plugin usage configuration (for more details, check sections in vimrc)
- Plugin usage can be configured in the first section of vimrc
```
" ============================================================================
" Vim and Neovim settings
" ============================================================================
" Select vim-plug to load, set guicolor (real color) support, and etc.
" Assign 0 to disable plug option
```
- Dectect using neovim or not (automatical detection)
```
" Use vim or neovim (Auto-detect)
let using_neovim = has('nvim')
let using_vim = !using_neovim
```
- Check if using vim 8.0 or higher
    - If vim version is less than 8.0, some function is not vailable (e.g. terminal)
```
" Check vim version for remote machine that vim <= 8.0 (e.g. Fomalhaut)
let using_vim8 = 1
```
- Customize vim colorscheme
    - For fancy symbol support, nerd font is needed (check https://github.com/ryanoasis/nerd-fonts)
    - For pywal theme support, pywal is needed (check https://github.com/dylanaraps/pywal), also remember to change the directory path to your $HOME/.cache/wal
```
" Customize vim theme (Include colortheme and statusline)
let using_customized_theme = 1
" Fancy symbols (Mainly affect nerdtree and lightline)
let using_fancy_symbols = 1
" Wal theme support (Pywal theme support, check pywal)
"let using_wal_theme = 0
let using_wal_theme = isdirectory('/home/jordankhwu/.cache/wal')
```
- Extra vim-plug
```
" Extra vim-plug (Include easymotion, yankring, autocolpop, and etc.)
let using_extra_plug = 1
```
- Coding tool vim-plug
```
" Coding tools vim-plug (Include syntax support, git function, and etc.)
let using_coding_tool_plug = 1
```
- Python completion vim-plug
```
" Python Completion (Use deoplete and jedi, neovim is recommended to be used)
let using_python_completion = 1
```
- GUI support
```
" Support of externaml gui software (e.g. Okular, Google-chrome, and etc.)
let using_gui_software = 1

```
- Customized terminal support
    - Use assigned shell instead of default system one
    - Also enable keymapping for terminal mode (need vim >= 8.0)
```
" Vim >= 8.0 can call termininal inside vim (But very time-consuming)
let using_customized_terminal = 0
```

### Keymapping - Customized Keymapping Rule
> 1. Keymapping should not be much different from the original VIM
- To make life easier instead of filled up with bloated keymapping
> 2. Every function (motion) should start with a leader key for most of time
- To prevent conflict with built-in hotkey or other program hotkeys
- In this configuration is __SPACE__ key
> 3. Keymapping should be related to the name of the function
- Make it easier to remember or connect
- e.g. "no wrap" function is mapped to [SPACE]+[W]+[P]

### Keymapping Sheet 1 - Fn Key Keymapping

#### Function Key Keymapping
| VIM-Mode | Keymapping                  | Function                      | Descrption                            | Note |
| :-----:  | :-------------------------: | :---------------------------: | :-----------------------------------: | :--: |
| N/V      | ([LK])+[F1]                 | (Previous)/Next Buffer        | Switch between buffers                |
| N/V      | ([LK])+[F2]                 | (Previous)/Next Tab           | Switch between tabs                   |
| N/V      | [F3]                        | Nerdtree current file         | Show current file location            |
| N/V      | [LK]+[F3]                   | Toggle Nerdtree               | On/Off NerdTree plugin                |
| N/V      | [F4]                        | Markdown/Latex previewer      | Open external Viewer                  | Only for .md or .tex file |
| N/V      | [LK]+[F4]                   | Toggle Tagbar                 | On/Off Tagbar plugin                  |
| N/V      | ([LK])+[F5]                 | Toggle (Rel)/Abs linenumber   | On/Off rel/abs linenumber             |
| N/V      | ([LK])+[F6]                 | (OFF)/ON foldcolumn           | Off/On foldcolumn                     | For easier code fold visualization |
| N/V      | ([LK])+[F7]                 | (OFF)/ON show line border     | Off/On hightlight 79th character      | VIM recommends at most 78 characters for one line |
| N/V      | ([LK])+[F8]                 | (OFF)/ON highlight comment    | Off/On hightlight code comment        | Assign brighter color to comment to hightlight it |
| N/V      | [F9]                        | Toggle autopair               | On/Off autopair quotation             |
| N/V      | [LK]+[F9]                   | Toogle synchronized cursor    | Toggle synchronized cursor for splits | For neovim version < 0.5 |
| N/V      | [LK]+[F9]                   | Toggle code minimap scrollbar | Toggle code minimap scrollbar         | For neovim version >= 0.5, and minicode is installed |
| N/V      | ([LK])+[F10]                | Open terminal                 | Open terminal in vim buffer           | Need vim version >= 8.0 |

### Keymapping Sheet 2 - Built-in Function Keymapping

#### 1. Split/Window keymapping
| VIM-Mode | Keymapping                  | Function                      | Descrption                            | Note |
| :-----:  | :-------------------------: | :---------------------------: | :-----------------------------------: | :--: |
| N/V      | [LK]+[w]+[x/v]              | Add new split Horiz/Vertical  | Add new split Horizontal/Vertial      |
| N/V      | [LK]+[w]+[Shift]+[x/v]      | Add current split Horiz/Verti | Add current split Horizontal/Vertial  | Duplicate original split, just add [Shift] to [x]/[v]| |
| N/V      | [LK]+[w]+[t]                | Move current split to new tab | Move current split to new tab         | Here t for (t)ab
| N/V      | [LK]+[w]+[n]                | Add new empty spli            | Add new empty split                   | Here n for (n)ew
| N/V      | [LK]+[w]+[c]                | Close current split           | Close current split                   | Here c for (c)lose
| N/V      | [LK]+[w]+[;]                | Cycle exist split             | Cycle exist split                     |
| N/V      | [Ctrl]+[h/j/k/l]            | Move between vim splits       | Move between splits (L/D/U/R)         | With plugin, you can even move between TMUX pane and VIM splits |
| N/V      | [LK]+[h/j/k/l]              | Move between vim splits       | Move between splits (L/D/U/R)         |
| N/V      | [LK]+[Shift]+[h/j/k/l]      | Move current split (L/D/U/R)  | Move current split (L/D/U/R)          |
| N/V      | [-]/[=]                     | Inc/Dec split height          | +5/-5 rows split height               |
| N/V      | [_]/[+]                     | Inc/Dec split width           | +5/-5 columns split width             | Just add [Shift] to [-]/[=] |
| N/V      | [LK]+[=]+[=]                | Resplit splits equally        | Resplit splits equally                | Here =(equal sign) for equally split

#### 2.Code Folding Keymapping
| VIM-Mode | Keymapping                  | Function                      | Descrption                            | Note |
| :-----:  | :-------------------------: | :---------------------------: | :-----------------------------------: | :--: |
| N        | [LK]+[s]+[v]                | Save layout and folding       | Save current split and code folding   | Here sv for (s)a(v)e
| N        | [LK]+[l]+[d]                | Load layout and folding       | Load previous split and code folding  | Here ld for {l}oa(d)
| N/V      | [LK]+[f]+[f]                | Toggle current folding        | Show/Close current folding            |
| N/V      | [LK]+[s]+[f]                | Show all foldings             | Show all foldings                     | Here s for (s)how
| N/V      | [LK]+[c]+[f]                | Close all foldings            | Close all foldings                    | Here c for (c)lose



    Shift+k
    ii
    kj
#### 3.Miscellaneous Function Keymapping
| VIM-Mode | Keymapping                  | Function                      | Descrption                            | Note |
| :-----:  | :-------------------------: | :---------------------------: | :-----------------------------------: | :--: |
| I        | [i]+[i]/[k]+[j]             | Esc (escape form insert mode) | Esc (escape form insert mode)         | If your word contains "ii", try [i] + "[Ctrl]+[v]" + [i]
| N/V      | [Shift]+[k]                 | Search current word in mannual| Search current word in mannual        |
| N/V      | [LK]+[d]+[d]                | Close current buffer          | Close current buffer                  | Here d for (d)eletion
| N/V      | [Alt]+[Left/Right]          | Change current tab order      | Change current tab to prev/next       |
| N/V      | [LK]+[w]+[p]                | Toggle line wrap              | On/Off line wrap                      | Here wp for (w)ra(p)
| N/V      | [LK]+([Shift])+[/]          | Toggle search highlight       | On/Off search highlight               |
| N/V      | [LK]+[m]+[Shift]+[k]        | Show all vim marks            | Show all vim marks                    | [LK]+[m]+[k] shows marks using fzf instead vim built-in
| N/V      | [LK]+[r]+[e]                | Show all vim regiesters       | Show all vim registers                | Here re for (re)gister
| N/V      | [LK]+[a]+[b]                | Show all vim abbreviates      | Show all vim abbreviates              | Here ab for (ab)reviation

### Keymapping Sheet 3 - Plug-in Function Keymapping

#### File/Code Browsing Keymapping
- Note: Fzf is needed for file browsing
| VIM-Mode | Keymapping                  | Function                      | Descrption                            | Note |
| :-----:  | :-------------------------: | :---------------------------: | :-----------------------------------: | :--: |
| N/V      | [F3]                        | Nerdtree Current Files        | Show current file location            |
| N/V      | [LK]+[F3]                   | Toggle Nerdtree               | On/Off NerdTree plugin                |
| N/V      | [LK]+[F4]                   | Toggle Tagbar                 | On/Off Tagbar plugin                  |
| N        | [LK]+[f]+[s]                | List files under input dir    | List files under input dir            |
| N        | [LK]+[l]+[c]                | Locate files matched input    | Locate files matched input name       | Use system locate command |
| N        | [LK]+[r]+[g]                | Find files with input pattern | Find files matched input patterm      | Use system ripgrep command |
| N        | [LK]+[f]+[t]                | Select filetype for current   | Select filestype for current file     |
| N        | [LK]+[c]+[d]                | Show all command in vim now　 | Show all command in vim now           |　
| N        | [LK]+[n]+[m]                | Show all normal mode mapping  | Show all normal mode mapping          |
| N        | [LK]+[h]+[t]                | Show all helptag in vim-help  | Show all helptag in vim-help          |

#### Python Coding Keymapping
- Note: Jedi is needed for python code analysis (Check https://github.com/davidhalter/jedi)
- Note: All below functions only work in .py files
| VIM-Mode | Keymapping                  | Function                      | Descrption                            | Note |
| :-----:  | :-------------------------: | :---------------------------: | :-----------------------------------: | :--: |
| N/V      | [Shift]+[k]                 | Search current word in doc    | Search current word in python doc     |
| N/V      | [LK]+[j]+[n]                | Find current word occurences  | Find current word occurences          | Here j for (j)edi
| N/V      | [LK]+[j]+[a]                | Find current word assignment  | Find current word assignment          |
| N/V      | [LK]+[j]+[d]                | Show current word definition  | Show current word definition          |
| N/V      | [LK]+[j]+[m]                | Show input module init.py     | Show input module init.py             |
| N/V      | [LK]+[j]+[Shift]+[m]        | Show current word init.py     | Show current word init.py             |

#### Miscellaneous Function Keymapping
- Note: "let_using_extra_plug = 1" must be set in vimrc
| VIM-Mode | Keymapping                  | Function                      | Descrption                            | Note |
| :-----:  | :-------------------------: | :---------------------------: | :-----------------------------------: | :--: |
| N/V      | [LK]+[Return]               | Select vim pane               | Select vim pane in tabs and splits    |

### Reference for VIM setup
- http://fisadev.github.io/fisa-vim-config/
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
