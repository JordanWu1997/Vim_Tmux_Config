" .vimrc
" ============================================================================
" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" Modified [Vim]/[Neovim] version:[8.2]/[v0.4.4] by Kuan-Hsien Wu, Sheng-Jun Lin
" ============================================================================
" This vim configuration is for both vim and neovim
" Note:
" Vim / Neovim configuration file --------------------------------------------
" -- Vim configuration file
"    -- Store in ~/.vimrc
" -- Neovim configuration file
"    -- Store in ~/.config/nvim/init.vim

" Note:
" Old Powerline-status support [Not use anymore, use lightline now] ----------
" -- Powerline-status Installation (Choose one of the following)
"    (1) sudo intall vim-powerline (Fedora)
"    (2) sudo apt-get install powerline (Ubuntu)
"    (3) activate manually
"        -- python3 from powerline.vim import setup as powerline_setup
"        -- python3 powerline_setup()
"        -- python3 del powerline_setup

" Note:
" For special character support ----------------------------------------------
" -- NERDFont Installation (Step by step)
"    (1) mkdir -p ~/.local/share/fonts
"    (2) cd ~/.local/share/fonts && curl -fLo \
"        "Droid Sans Mono for Powerline Nerd Font Complete.otf" \
"        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/\
"        DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
"    (3) set terminal font to "DroidSansMono Nerd Font"

" Note:
" Vim-Plugin Support ---------------------------------------------------------
" -- If curl is installed, vim-plug (vim-plugin manger) should automatically
"    run all installaion at your first time loading vim.
" -- If vim-plug somehow not working automatically or if you want mannual
"    installation, in vim command mode, type :PlugInstall

" Note:
" Vim-Features Support -------------------------------------------------------
" -- In Fedora, vim is complied without clipboard and python3/dyn features,
" -- For those feature support, you can try either recomplie vim from source
"    codes or [Recommended] just install gvim (gui-vim) from Fedora instead.
"    Also, xclip MUST be installed [dnf install xclip]

" Note:
" Leaderkey Delay Solution ---------------------------------------------------
" -- In the following configuration, I use space as leaderkey, however, it
"    will encounter delay problem in insert mode (Need wait for a while to
"    insert space character) since vim always waits to see if you want to
"    press more keys to execute some function mapped in insert mode.
" -- For now, there are two solutions: One is to set leaderkey to other key
"    than space; The other one (RECOMMENDED) is to remap all keymaps that
"    start with space in INSERTMODE (which can be found by vim command :imap)

" Note:
" Neoformat (Formatter) ------------------------------------------------------
" -- Call multi-language code formatter [formatter need to be installed]
" -- For code formatter support: https://github.com/sbdchd/Neoformat
"    -- Example: python code formatter
"       -- # Install formatter with terminal  : pip install yapf
"       -- # Use formatter in vim command line: :Neoformat! python yapf
"       -- Recommendation  usage set (in order):
"           (1) :Neoformat isort   # Sort import module
"           (2) :Neoformat pyment  # Add description of function/class
"           (3) :Neoformat yasf    # Format to PEP8 standard
"
" Note:
" Python-completion and tmux-yank-clipboard on ZEUS --------------------------
" -- Use neovim and everything is fine, but notice that neovim support of
"    Fedora repo is for Fedora 25 and higher version. For now, Seb used
"    AppImage directly from neovim website
" -- Python-completion dependence
"    -- jedi-Vim: pip install jedi
"    -- deoplete: pip install pynvim
"    -- ipdb    : pip install ipdb

" Note:
" Wal.vim (autotheme color palette support)
" -- Wal.vim cannot be automatically import to lightline.Vim. For now, I just
" link wal.vim mannually to lightline by below command:
"   ln -s ~/.config/nvim/plugged/wal.vim/autoload/lightline/colorscheme/wal.vim \
"   ~/.config/nvim/plugged/lightline.vim/autoload/lightline

" ============================================================================
" Vim and Neovim settings
" ============================================================================
" Select vim-plug to load, set guicolor (real color) support, and etc.
" Assign 0 to disable plug option

" Enable/Disable Vim-plug ----------------------------------------------------
" Use vim or neovim (Auto-detect)
let using_neovim = has('nvim')
let using_vim = !using_neovim
" Check vim version for remote machine that vim <= 8.0 (e.g. Fomalhaut)
let using_vim8 = 1
" Customize vim theme (Include colortheme and statusline)
let using_customized_theme = 1
" Fancy symbols (Mainly affect nerdtree and lightline)
let using_fancy_symbols = 1
" Wal theme support (Pywal theme support, check pywal)
let using_wal_theme = 0
"let using_wal_theme = isdirectory('/home/jordankhwu/.cache/wal')
" Extra vim-plug (Include easymotion, yankring, autocolpop, and etc.)
let using_extra_plug = 1
" Coding tools vim-plug (Include syntax support, git function, and etc.)
let using_coding_tool_plug = 1
" Python Completion (Use deoplete and jedi, neovim is recommended to be used)
let using_python_completion = 1
" Support of externaml gui software (e.g. Okular, Google-chrome, and etc.)
let using_gui_software = 1

" TERM GUI color -------------------------------------------------------------
if has('termguicolors') && !using_wal_theme
    set termguicolors
endif
" 256 term color support in vim TUI
if !has('gui_running')
    set t_Co=256
endif

" ============================================================================
" Vim built-in function settings and Vim hotkeys settings
" ============================================================================
" All parameter settings and hotkey mappings

" Set leaderkey --------------------------------------------------------------
let mapleader = ' '

" Map insert mode Esc key ----------------------------------------------------
" - Use Ctrl+v to escape
imap ii <Esc>
imap kj <Esc>

" Save/Load file hotkey ------------------------------------------------------
" - ZZ (Quit and save if there's change in file)
" - :f <new-filename> (Save current file with new filename)
map <leader>q  :q<CR>
map <leader>Q  :qall<CR>
map <leader>ww :w<CR>
map <leader>wq :wq<CR>
" Overwrite (Not working for now, use plug-in suda.vim instead)
"command! Sudow execute 'w !sudo -S tee % > /dev/null'

" External command -----------------------------------------------------------
" -- K (Manpage for current selected word)
" -- :r !date (Insert timestamp)
" -- :!dir (Show current directory file)
" -- :!del FILENAME (Delete FILENAME)

" Vim built-in setting -------------------------------------------------------
filetype on
" Following settings are automatically executed by VIM-plug
"filetype plugin on
"filetype indent on
"syntax enable

" Vim window/pane/fold configuration -----------------------------------------
map <silent><F10> :mkview<CR>:echo 'Current Layout Setting Saved ...'<CR>
map <silent><leader><F10> :loadview<CR>:echo 'Layout Setting Loaded ...'<CR>

" Vim split window (pane) control --------------------------------------------
" Split pane - More natural split opening
set splitbelow
set splitright
" Split pane navigation [Now integrate with tmux, check vim-tmux-navigator]
nmap <silent><leader>w; <C-W><C-W>
nmap <silent><leader>wh :wincmd h<CR>
nmap <silent><leader>wj :wincmd j<CR>
nmap <silent><leader>wk :wincmd k<CR>
nmap <silent><leader>wl :wincmd l<CR>
" Split pane location swap
nmap <silent><leader>wH :wincmd H<CR>
nmap <silent><leader>wJ :wincmd J<CR>
nmap <silent><leader>wK :wincmd K<CR>
nmap <silent><leader>wL :wincmd L<CR>
" Split pane resize
nmap <silent>= :resize +5<CR>
nmap <silent>- :resize -5<CR>
nmap <silent>+ :vertical resize +5<CR>
nmap <silent>_ :vertical resize -5<CR>
" Redraw pane equally
nmap <silent><leader>w= :wincmd =<CR>
" Move current split to new tab
nmap <silent><leader>wt :wincmd T<CR>
" Close current split
nmap <silent><leader>wc :wincmd c<CR>
" Create new empty split
nmap <silent><leader>wn :wincmd n<CR>
" Split pane action
nmap <silent><leader>w- :split<CR>:echo 'Split Current File'<CR>
nmap <silent><leader>w\ :vsplit<CR>: echo 'Vsplit Current File'<CR>
nmap <leader>w_ :split<space>
nmap <leader>w\| :vsplit<space>

" Vim settings ---------------------------------------------------------------
set nocompatible          " Not compatible with traditional vi
set confirm               " Ask for confirmation before leaving vim
set ignorecase            " Close case sensitive
"set smartcase            " Case sensitive if search contains uppercase letter
set modifiable            " Make editing buffer modifable
set encoding=utf-8        " Unicode display
set clipboard=unnamedplus " Shared system clipboard, gvim must be installed for vim

" Line wrap ------------------------------------------------------------------
set nowrap                " Line wrap for small monitor or display window
map <leader>wp :set wrap!<CR>:echo 'Toggle Line Wrap'<CR>

" Wild menu settings ---------------------------------------------------------
set wildmenu              " Show memu options
set wildmode=list:full    " Show all available input options (or use Ctrl-D)

" Cursor settings ------------------------------------------------------------
set ruler                 " Show cursor position in statusline
set cursorline            " Show vertical line
set cursorcolumn          " Show horizontal line (laggy in neovim)
" Synchronize cursor between files
" Must be execute in all files that you want to synchronize cursors
map <F9> :set cursorbind<CR>:echo 'Synchronized Cursor On'<CR>
map <leader><F9> :set nocursorbind<CR>:echo 'Synchronized Cursor Off'<CR>

" Display settings -----------------------------------------------------------
set scrolloff=3           " Keep cursor 3 lines away from bottom
set display+=lastline     " Show line as much as possible
set title                 " Let vim change terminal title

" Search settings ------------------------------------------------------------
set incsearch
set hlsearch
map <leader>/ :set nohlsearch!<CR>:echo 'Toggle Search Highlight'<CR>

" Line number settings -------------------------------------------------------
set number
set relativenumber
map <leader><F5> :set number!<CR>:echo 'Toggle Line Number'<CR>
map <F5> :set relativenumber!<CR>:echo 'Toggle Rel Line Number'<CR>

" Fold settings --------------------------------------------------------------
set nofoldenable
set foldmethod=indent
autocmd FileType python setlocal foldmethod=indent
map <silent><leader>ff za<CR>:echo 'Toggle Current Fold...'<CR>
map <silent><leader>cf zM<CR>:echo 'Close All Folds ...'<CR>
map <silent><leader>sf zR<CR>:echo 'Show All Folds ...'<CR>

" Tabe (window) settings -----------------------------------------------------
" Tabe (window) operations
map <leader>ts :tabs<CR>
map <leader>tt :tabnew<space>
map <leader>td :tabclose<space>
map <silent><leader>tdd :tabclose<CR>:echo 'CLOSE CURRENT TAB ...'<CR>
" Tabe (window) navigation
map <silent><F2> <Esc>:tabnext<CR>:echo 'NEXT TAB ...'<CR>
map <silent><leader><F2> <Esc>:tabprevious<CR>:echo 'PREV TAB ...'<CR>
" Tabe (window) navigation (C-Left/Right will be overwrited in TMUX session)
map <silent><C-Left>  :tabprevious<CR>:echo 'PREV TAB ...'<CR>
map <silent><C-Right> :tabnext<CR>:echo 'NEXT TAB ...'<CR>
" Tabe (Window) swap
map <silent><A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
map <silent><A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Buffer settings ------------------------------------------------------------
" -- Reference: https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
" -- Useful command: ':e#' or 'Ctrl-^' to edit between two buffers
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif
    if bufnr("%") == l:currentBufNum
        new
    endif
    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
" A buffer not becomes hidden (send to background) when it is abandoned
set nohidden
" List all buffers and status
"map <silent><leader>ls :ls<CR>
" Load buffer
map <leader>b :b<space>
" Add buffer in foreground
map <leader>bb :edit<space>
" Add buffer in background
map <leader>ba :badd<space>
" Delete buffer
map <leader>bd :bdelete<space>
map <silent><leader>dd :bdelete<CR>:echo 'DELETE CURRENT BUFFER [PRESS CTRL+O TO RECOVER]'<CR>
map <silent><leader>bdd :bdelete<CR>:echo 'DELETE CURRENT BUFFER ...'<CR>
" Navigate through buffers
map <silent><leader><F1> <Esc>:bp<CR>:echo 'PREV BUFFER ...'<CR>
map <silent><F1> <Esc>:bn<CR>:echo 'NEXT BUFFER ...'<CR>

" Marks settings -------------------------------------------------------------
map <leader>mk :marks<CR>
map <leader>md :delmarks<space>

" Registers settings ---------------------------------------------------------
" Show registers in vim
map <leader>re :registers<CR>
" Command that wipe out all registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Abbreviation settings ------------------------------------------------------
map <leader>ab :abbreviate<CR>

" Better backup, swap and undos storage --------------------------------------
if using_neovim
    set directory=~/.config/nvim/dirs/tmp     " Directory to place swap files in
    set backup                                " Make backup files
    set backupdir=~/.config/nvim/dirs/backups " Where to put backup files
    set undofile                              " Persistent undos - undo after re-opening
    set undodir=~/.config/nvim/dirs/undos
    set viminfo+=n~/.config/nvim/dirs/viminfo
    " Create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, 'p')
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, 'p')
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, 'p')
    endif
else
    set directory=~/.vim/dirs/tmp     " Directory to place swap files in
    set backup                        " Make backup files
    set backupdir=~/.vim/dirs/backups " Where to put backup files
    set undofile                      " Persistent undos - undo after re-opening
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " Create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, 'p')
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, 'p')
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, 'p')
    endif
endif

" Function - No system bell --------------------------------------------------
set visualbell    " ┐
set noerrorbells  " │ Disable beeping and window flashing
set t_vb=         " ┘ https://vim.wikia.com/wiki/Disable_beeping

" Function - Autoremove whitespace in end of line ----------------------------
" - Remove trailing whitespace when writing a buffer, but not for diff files.
" - From Vigil <vim5632@rainslide.net>
function! RemoveTrailingWhitespace()
    if &ft != 'diff'
        let b:curcol = col('.')
        let b:curline = line('.')
        silent! %s/\s\+$//
        silent! %s/\(\s*\n\)\+\%$//
        call cursor(b:curline, b:curcol)
    endif
endfunction
" Remove trailing whitespace for editing files
autocmd BufWritePre * call RemoveTrailingWhitespace()
map <leader>rm :call RemoveTrailingWhitespace()<CR>:echo "Remove Tail Whitespaces"<CR>

" Function - Foldcolumn display ----------------------------------------------
map <F6> :set foldcolumn=6<CR>:echo 'Foldcolumn ON'<CR>
map <leader><F6> :set foldcolumn=0<CR>:echo 'Foldcolumn OFF'<CR>

" Function - Hex editor ------------------------------------------------------
" From https://blog.gtwang.org/useful-tools/how-to-use-vim-as-a-hex-editor/
"map <leader>ho :%! xxd<CR>:echo 'Hex editor on: TF to binary data'<CR>
"map <leader>hf :%! xxd -r<CR>:echo 'Hex editor off: TF to original data'<CR>

" ============================================================================
" Customized terminal mode (Only support for vim >= 8.0)
" ============================================================================
" Vim support built-in terminal, deafult use system $SHELL

" Terminal mode - open terminal in vim buffer --------------------------------
" -- Enter insert mode to use terminal command line
" -- In terminal buffer, <C-\><C-n> back to normal mode

" Set customized terminal shell and keymapping
if using_vim8
    " Map key to go back from terminal mode to normal mode
    " Do not use Esc (which conflicts with fzf window)
    tmap <leader><F12> <C-\><C-n>:echo 'Back to Normal Mode'<CR>
    tmap ii <C-\><C-n>:echo 'Back to Normal Mode'<CR>
    tmap kj <C-\><C-n>:echo 'Back to Normal Mode'<CR>
    tmap <C-h> <C-\><C-n><C-w>h
    tmap <C-j> <C-\><C-n><C-w>j
    tmap <C-k> <C-\><C-n><C-w>k
    tmap <C-l> <C-\><C-n><C-w>l
    if using_neovim
        map <F12> :term<CR>
    else
        map <F12> :terminal<CR>
    endif
endif

" ============================================================================
" Vim-plug initialization (Get vim-plug by curl)
" ============================================================================
" Avoid modify this section, unless you are very sure of what you are doing
" Note: curl must already be installed

" Setup Vim-Plug path for neovim or vim
let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif

" Install Vim-Plug for neovim or vim
if !filereadable(vim_plug_path)
    echo 'Installing Vim-plug...'
    echo ''
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" Manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" ============================================================================
" Vim active plugins
" ============================================================================
" You can disable or add new ones here:

" This needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Plugins from github repos:
" ****************************************************************************

" [Vim theme] ----------------------------------------------------------------
if using_customized_theme
    " Color themes (Monokair - high contrast)
    Plug 'patstockwell/vim-monokai-tasty'
    " Color themes (Gruvbox - low contrast)
    Plug 'morhetz/gruvbox'
    " Lightline (status line)
    Plug 'itchyny/lightline.vim'
    " Lightline bufferline
    Plug 'mengelbrecht/lightline-bufferline'
    " Wal (Autocolorcheme based on wallpaper) [Only work with Cterm color]
    Plug 'dylanaraps/wal.vim'
endif

" [File/Code Browsing] -------------------------------------------------------
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" File browser [Support netrw (vim built-in file browser) functions]
Plug 'scrooloose/nerdtree'
if using_fancy_symbols
    " Nerdtree and other vim-plug powerline symbols support
    Plug 'ryanoasis/vim-devicons'
    " More highlight in nertree (make nerdtree laggy in large filetree)
    " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif
"Class/module browser
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" [Vim useful functions] -----------------------------------------------------
" Sudo write/read files in vim
Plug 'lambdalisue/suda.vim'
"" Vim settings for opening large files
Plug 'vim-scripts/LargeFile'
" System Man usage
Plug 'vim-utils/vim-man', { 'on': 'Man' }
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Generate bracket/quotation in pair
Plug 'tpope/vim-surround'
" Enable . (repeat) motion for external plugin commands
Plug 'tpope/vim-repeat'
" Vim window maximizer
Plug 'szw/vim-maximizer'
" Window pane selector
Plug 't9md/vim-choosewin'
" Autopair for quotations and brackets
Plug 'jiangmiao/auto-pairs'

" [Vim extra functions] ------------------------------------------------------
if using_extra_plug
    if using_neovim
        "" Override configs by directory [Time-consuming for initialization]
        "Plug 'arielrossanigo/dir-configs-override.vim'
        " Fancy startup page of vim [Not use in vim, too loadtime-consuming]
        Plug 'mhinz/vim-startify'
        " Vim smooth scroll
        Plug 'yuttie/comfortable-motion.vim'
        "" Goyo (Distraction-free mode)
        "Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
        "" Vim-wiki (Note-taking)
        "Plug 'vimwiki/vimwiki', { 'on': 'VimwikiUISelect' }
    endif
    " History of yank
    Plug 'vim-scripts/YankRing.vim'
    " Register investigator
    Plug 'junegunn/vim-peekaboo'
    " Easymotion (Key-mapping moving in vim)
    Plug 'easymotion/vim-easymotion'
    " Auto popup completion options from vim
    Plug 'vim-scripts/AutoComplPop'
    " Pending tasks list
    Plug 'fisadev/FixedTaskList.vim', { 'on': 'TaskList' }
    " Paint css colors with the real color
    " [Integrated in 'gko/vim-coloresque' which is laggy with cursorcolumn]
    Plug 'lilydjwg/colorizer'
endif

" [Functions for coding] -----------------------------------------------------
if using_coding_tool_plug
    if using_vim8
        " Languge packs [Not working on fomalhaut (vim=7.0)]
        Plug 'sheerun/vim-polyglot'
        " Multiple language syntax support [Not working on fomalhaut (vim=7.0)]
        Plug 'dense-analysis/ale', { 'for': ['python', 'fortran', 'html'] }
        "" Syntax support (Improved syntastics, here just use ale instead)
        " Plug 'neomake/neomake'
        "" Multiple language inspector [Powerful but too complicated]
        " Plug 'puremourning/vimspector'
    endif
    " Code formatter
    Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
    " Paint paired bracket/quotation in different color
    Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' }
    " Indent line guide [Color column]
    Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }
    " Indent text object (i for indent as w for word)
    Plug 'michaeljsmith/vim-indent-object'
     "Multiple cursor with incsearch support
    Plug 'terryma/vim-multiple-cursors'
    " Git integration (Git functions in vim command line)
    Plug 'tpope/vim-fugitive', { 'on': 'Git' }
    " Git/mercurial/others diff icons on the side of the file lines
    "Plug 'mhinz/vim-signify', { 'on': 'SignifyToggle' }
    Plug 'mhinz/vim-signify'
    " File Minimap (Need neovim Ver. >= 0.5)
    if has('nvim-0.5')
        Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
    endif
endif

" [Tmux] ---------------------------------------------------------------------
if using_neovim
    " Share focus between vim and tmux [Needed for clilpboard sharing]
    Plug 'tmux-plugins/vim-tmux-focus-events'
    " Share clipboard between vim and tmux
    Plug 'roxma/vim-tmux-clipboard'
endif
" Navigate seamlessly in vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" [Python coding] ------------------------------------------------------------
if using_python_completion
    " Python autocompletion
    if using_neovim && vim_plug_just_installed
        Plug 'Shougo/deoplete.nvim', { 'do': ':autocmd VimEnter * UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim', { 'for': 'python' }
    endif
    " Yet Another Remote Plugin Framework for Neovim [needed for deoplete.nvim]
    Plug 'roxma/nvim-yarp', { 'for': 'python' }
    " Help communicate beteen vim and neovim [needed for deoplete.nvim]
    Plug 'roxma/vim-hug-neovim-rpc', { 'for': 'python' }
    " Python autocompletion
    Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
    " Completion from other opened files
    Plug 'Shougo/context_filetype.vim', { 'for': 'python' }
    " Just to add go-to-definition and similar features, autocompeletion from
    " this plugin is disabled
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
endif
" More python syntax highlight
Plug 'vim-python/python-syntax', { 'for': 'python' }
" Sort python import (Integrate with neoformat now [Neovim only])
"Plug 'fisadev/vim-isort', { 'on': 'Isort', 'for': 'python' }

" [Fortran coding] -----------------------------------------------------------
" Fortran syntax support
Plug 'tomedunn/vim.fortran', { 'for': 'fortran' }

" [HTML coding] --------------------------------------------------------------
" Generate html in a simple way
Plug 'mattn/emmet-vim', { 'for': 'html' }
" Generate closetag for HTML
Plug 'alvan/vim-closetag', { 'for': 'html' }

" [Latex] --------------------------------------------------------------------
" Latex compiler link support (complier need to be installed externally)
Plug 'vim-latex/vim-latex', { 'for': 'tex' }
" Real time Tex -> Pdf file preview (pdf reader is needed)
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" Check vim startup time and loaded plugins
" vim --startuptime timeCost.txt timeCost.txt

" ============================================================================
" Install plugins the first time vim runs
" ============================================================================
if vim_plug_just_installed
    echo "Installing bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Part 1 - Common settings (Plugins settings and mappings)
" ============================================================================

" Tab key settings [Must be added after vim-plug] ----------------------------
set expandtab       " expand tab to spaces
set tabstop=4       " numbers of space that tab in the file counts
set shiftwidth=4    " number of space of auto-indent length
set softtabstop=-1  " numbers of space that tab while editing
                    " negative value -> adopt shiftwidth value

" Filetype-dependent tab key settings ----------------------------------------
" PEP8 recommendation for tab settings
autocmd FileType python setlocal et ts=4 sw=4 sts=4
" Makefile not support expand tabs to spaces
autocmd FileType make setlocal noet

" Tab key action in all modes ------------------------------------------------
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv

" ============================================================================
" Part 2 - Vim-theme settings (Plugins settings and mappings)
" ============================================================================
" Vim-theme settings, edit them as you wish.
" As for colorscheme, it at the end of this plug settings section

" Lightline ------------------------------------------------------------------
if using_customized_theme
    if using_wal_theme
        let g:lightline = {
            \ 'colorscheme': 'wal',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }
    else
        if using_fancy_symbols
            let g:lightline = {
                \ 'colorscheme': 'deus',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                \ },
                \ 'component_function': {
                \   'gitbranch': 'FugitiveHead'
                \ },
                \ 'separator': {
                \   'left': "", "right": ""
                \ },
                \ 'subseparator': {
                \   'left': '/', 'right': '/'
                \ },
                \ }
        else
            let g:lightline = {
                \ 'colorscheme': 'deus',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                \ },
                \ 'component_function': {
                \   'gitbranch': 'FugitiveHead'
                \ },
                \ }
        endif
    endif
endif

" Lightline tabline ----------------------------------------------------------
if using_customized_theme
    let g:lightline#bufferline#show_number  = 0
    let g:lightline#bufferline#shorten_path = 0
    let g:lightline#bufferline#unnamed      = '[No Name]'
    let g:lightline.tabline          = { 'left': [ ['tabs'] ],
                                        \ 'right': [ ['buffers'] ] }
    let g:lightline.component_expand = { 'buffers': 'lightline#bufferline#buffers' }
    let g:lightline.component_type   = { 'buffers': 'tabsel' }
    " Central bar transparency
    let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
    let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
    let s:palette.visual.middle = s:palette.normal.middle
    let s:palette.insert.middle = s:palette.normal.middle
    let s:palette.inactive.middle = s:palette.normal.middle
    let s:palette.tabline.middle = s:palette.normal.middle
    let s:palette.replace.middle = s:palette.normal.middle
endif

" Status line ----------------------------------------------------------------
set noshowmode    " No vim-built-in mode statusline
set laststatus=2  " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set cmdheight=1   " Size of command line height
set showcmd       " This line must be added AFTER statusline plugin

" ============================================================================
" Part 3 - File/Code browsing settings (Plugins settings and mappings)
" ============================================================================
" File/Code browing settings, edit them as you wish.

" fzf.vim --------------------------------------------------------------------
" Caution:
"   - ripgrep must be installed if Rg function is needed
"   - if syntax highlight is needed, please install bat from command line
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }
" Default fzf layout (Floating in the center of window)
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" Buffer (Local vim)
nmap <leader>bL :BLines<CR>
nmap <leader>bl :execute ":BLines " . expand('<cword>')<CR>
nmap <leader>bT :BTags<CR>
nmap <leader>bt :execute ":BTag " . expand('<cword>')<CR>
" All files (Global system)
nmap <leader>gL :Lines<CR>
nmap <leader>gl :execute ":Lines " . expand('<cword>')<CR>
nmap <leader>gT :Tags<CR>
nmap <leader>gt :execute ":Tag " . expand('<cword>')<CR>
" File search
nmap <leader>ffs :Files<space>
nmap <leader>flc :Locate<space>
nmap <leader>frg :Rg<space>
" fzf key mapping
nmap <leader>fhs :History<CR>
nmap <leader>fh: :History:<CR>
nmap <leader>fh/ :History/<CR>
nmap <leader>fmk :Marks<CR>
nmap <leader>fbf :Buffers<CR>
nmap <leader>fwd :Windows<CR>
nmap <leader>fft :Filetypes<CR>
nmap <leader>fcd :Commands<CR>
nmap <leader>fmp :Maps<CR>
nmap <leader>fht :Helptags<CR>
" Line completion with current file [Use AutoComplPop instead]
"imap <c-x><c-l> <plug>(fzf-complete-line)
"" Word completion with dictionary
"imap <c-x><c-k> <plug>(fzf-complete-word)
"" Path completion with path
"imap <c-x><c-f> <plug>(fzf-complete-path)

" NERDTree -------------------------------------------------------------------
" Disable vim built-in netrw
let loaded_netrwPlugin = 1
" Open nerdtree with the current file selected
map <silent><F3> :NERDTreeFind<CR>
" Toggle nerdtree display
map <silent><leader><F3> :NERDTreeToggle<CR>
" Don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let g:NERDTreeMouseMode = 3
let g:NERDTreeDirArrows = ''
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

" Tagbar ---------------------------------------------------------------------
" autofocus on tagbar open
let g:tagbar_autofocus = 1
let g:tagbar_map_showproto = 'd'
" toggle tagbar display
map <silent><leader><F4> :TagbarToggle<CR>

" ============================================================================
" Part 4 - Vim useful functions settings (Plugins settings and mappings)
" ============================================================================
" Vim useful functions settings, edit them as you wish.

" LargeFile ------------------------------------------------------------------
" File unit: MB
let g:LargeFile = 10

" Vim-man --------------------------------------------------------------------
map <leader>m :execute ":Man " . expand('<cword>')<CR>
map <leader>M :Man<space>

" Nerdcommenter --------------------------------------------------------------
" Create default mappings
let g:NERDCreateDefaultMappings = 0
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0
" Use compact syntax for prettified multi-line comments
 let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Commenter mapping
map <silent><leader>ct :call NERDComment('n', 'Toggle')<CR>
map <silent><leader>cc :call NERDComment('n', 'Comment')<CR>
map <silent><leader>cu :call NERDComment('n', 'Uncomment')<CR>
map <silent><leader>cy :call NERDComment('n', 'Yank')<CR>

" Vim-surround ---------------------------------------------------------------
" Disable default surround mappings
"let g:surround_no_mappings = 1
" d: delete, c: change, y:yield
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap cS <Plug>CSurround
nmap ys <Plug>Ysurround
nmap yS <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround

" Vim maximizer --------------------------------------------------------------
 " [Default mapping is <F3> (Disabled now)]
let g:maximizer_set_default_mapping = 0
nmap <silent><leader>z :MaximizerToggle<CR>
vmap <silent><leader>z :MaximizerToggle<CR>gv

" Window-chooser (choosewin)--------------------------------------------------
map <leader><Enter> <Plug>(choosewin)
" Show big letters
let g:choosewin_overlay_enable = 1

" Autopairs -----------------------------------------------------------------
let g:AutoPairsShortcutToggle = '<M-p>'
let g:AutoPairsShortcutJump = '<M-j>'
let g:AutoPairsShortcutFastWrap = '<M-w>'

" ============================================================================
" Part 5 - Vim extra functions settings (Plugins settings and mappings)
" ============================================================================
" Vim extra functions settings, edit them as you wish.

" Comfortable motion ---------------------------------------------------------
if using_neovim && using_extra_plug
    " Disable default key mapping
    let g:comfortable_motion_no_default_key_mappings = 1
    " Enable motion with keyboard and mousewheel
    nmap <silent><C-f> :call comfortable_motion#flick(200)<CR>
    nmap <silent><C-b> :call comfortable_motion#flick(-200)<CR>
endif

" Vim-Wiki -------------------------------------------------------------------
"" Set markdown as default language
"let g:vimwiki_list = [{'path': '~/Documents/VIMWIKI/',
                      "\ 'syntax': 'markdown', 'ext': '.md'}]
"" Open vim-wiki selector
"nmap <leader>vw :VimwikiUISelect<CR>

" YankRing -------------------------------------------------------------------
" Yankring automatically remap built-in command key mapping
" -- e.g. "X[x]", "D[d]", "Y[y]", "P[p]", ".", "@", and etc.
if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    " Fix for yankring and neovim problem when system has non-text things
    " copied in clipboard
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif
map <leader>ys :YRShow<CR>:echo 'Show Yank History'<CR>
map <leader>yc :YRClear<CR>:echo 'Clear Yank History'<CR>

" Peekaboo -------------------------------------------------------------------
" Set leader as prefix for ('"' and '@') to peek registers in vim
let g:peekaboo_prefix='<leader>'

" Easymotion -----------------------------------------------------------------
" Move up and down not back to start of line
set nostartofline
" Disable default mappings
let g:EasyMotion_do_mapping = 0
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" Keep cursor column
let g:EasyMotion_startofline = 0
" JK motions: Line motions
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader>l <Plug>(easymotion-lineforward)
map <leader>h <Plug>(easymotion-linebackward)
map <leader>1 <Plug>(easymotion-overwin-f)
map <leader>2 <Plug>(easymotion-overwin-f2)

" AutoComplPop ---------------------------------------------------------------
" Enable/disable autopop
if using_python_completion
    autocmd FileType python let g:acp_enableAtStartup = 0
endif
map <leader>~ :AcpDisable<CR>:echo 'Disable Auto-Pop Suggestion'<CR>
map <leader>` :AcpEnable<CR>:echo 'Enable Auto-Pop Suggestion'<CR>

" Popup window selection -----------------------------------------------------
" Previous/next suggestion
" [Double quotation matters here, do not change to single quotation]
imap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
imap <expr><tab>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr><C-k>   pumvisible() ? "\<c-p>" : "\<C-k>"
imap <expr><C-j>   pumvisible() ? "\<c-n>" : "\<C-j>"
imap <expr><C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
imap <expr><C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Tasklist -------------------------------------------------------------------
map <leader>tl :TaskList<CR>

" ============================================================================
" Part 6 - Vim coding tools settings (Plugins settings and mappings)
" ============================================================================
" Vim coding tools settings, edit them as you wish.

" Ale (syntax check) ---------------------------------------------------------
let g:ale_enabled = 0
map <leader>al :ALEToggle<CR>

" Rainbow parentheses --------------------------------------------------------
" Don;t enable when start up
let g:rainbow_active = 0
map <leader>rb :RainbowToggle<CR>

" Indent guides --------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 4
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg='#303030' ctermbg=225
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#24242d' ctermbg=194
map <leader>ig :IndentGuidesToggle<CR>:echo 'Toggle Indent Guides'<CR>

" Multiple-cursors -----------------------------------------------------------
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-n>a'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-o>'
let g:multi_cursor_quit_key            = '<Esc>'

" Signify --------------------------------------------------------------------
" This first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" Mappings to jump to changed blocks
map <leader>sy :SignifyToggle<CR>
map <leader>sn <plug>(signify-next-hunk)
map <leader>sp <plug>(signify-prev-hunk)
" Nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Minimap --------------------------------------------------------------------
if has('nvim-0.5')
    let g:minimap_width = 5
    let g:minimap_auto_start = 0
    let g:minimap_auto_start_win_enter = 0
    let g:minimap_git_colors = 0
    let g:minimap_highlight_search = 0
    map <leader>mm :MinimapToggle<CR>
endif

" ============================================================================
" Part 7 - Python coding tools settings (Plugins settings and mappings)
" ============================================================================
" Python coding tools settings, edit them as you wish.

" Deoplete -------------------------------------------------------------------
if using_python_completion
    " Pynvim is needed [Installation: pip3 install --user pynvim]
    " Needed so deoplete can auto select the first suggestion
    set completeopt+=noinsert
    " Comment this line to enable autocompletion preview window
    " (displays documentation related to the selected completion option)
    " Disabled by default because preview makes the window flicker
    set completeopt-=preview
    " Use deoplete.
    let g:deoplete#enable_at_startup = 1
    autocmd FileType python call deoplete#custom#option({
    \   'ignore_case': v:true,
    \   'smart_case': v:true,
    \})
    " Complete with words from any opened file
    let g:context_filetype#same_filetypes = {}
    let g:context_filetype#same_filetypes._ = '_'
endif

" Jedi-vim -------------------------------------------------------------------
" All these mappings work only for python code [All should start with 'p']
if using_python_completion
    " jedi is needed [Installation: pip3 install --user jedi]
    " jedi-vim remaps K to open python documents
    " Disable autocompletion (using deoplete instead)
    let g:jedi#completions_enabled = 0
    " Use split instead of buffer
    let g:jedi#use_splits_not_buffers = "bottom"
    " Find ocurrences
    let g:jedi#usages_command = '<leader>pn'
    " Find assignments
    let g:jedi#goto_assignments_command = '<leader>pa'
    " Go to definition (in split pane)
    let g:jedi#goto_command = '<leader>pd'
    " Go to definition (in new tab)
    map <leader>pD :call jedi#goto()<CR>
    " Open python module [show __init__.py]
    map <leader>pm :execute ":Pyimport " . expand('<cword>')<CR>
    map <leader>pM :Pyimport<space>
endif

" Python syntax --------------------------------------------------------------
let g:python_highlight_all = 1

" Python debug (add python breakpoints) --------------------------------------
" [ipdb must be installed first]
" -- Installaion in termianl: run 'pip install ipdb'
autocmd FileType python map <silent><leader>\b Oimport ipdb; ipdb.set_trace()<Esc>

" ============================================================================
" Part 8 - Other language coding tools settings (Plugins settings and mappings)
" ============================================================================
" Other language support settings, edit them as you wish.
" Language support: Fortran, LaTex, Html, Markdown

" Fortran --------------------------------------------------------------------
" Ensure correct highlighting for
" Fortran free-form source code and turn syntax highlighting on
let fortran_free_source = 1
let fortran_do_enddo = 1

" LaTex ----------------------------------------------------------------------
autocmd FileType tex setlocal spell
autocmd FileType tex setl updatetime=10000 " Unit: milisecond
" Latex realtime viewer with gui pdf file manager
if using_gui_software
    let g:livepreview_previwer = 'okular'
    let g:livepreview_engine = 'pdflatex'
    autocmd BufEnter *.tex echom '[Press F4 to Preview .tex File]'
    autocmd FileType tex map <F4> :LLPStartPreview<CR>
endif

" Markdown -------------------------------------------------------------------
" From https://krehwell.com/blog/Open%20Markdown%20Previewer%20Through%20Vim
" Google-chrome extension is needed for markdown viewer
if using_gui_software
    let $VIMBROWSER='brave-browser'
    let $OPENBROWSER='map <F4> :!'. $VIMBROWSER .' %:p &<CR>'
    augroup OpenMdFile
        autocmd!
        autocmd BufEnter *.md echom '[Press F4 to Open .md File]'
        autocmd BufEnter *.md exe $OPENBROWSER
    augroup END
endif

" ============================================================================
" Part 9 - Colorscheme and other color settings (Plugins settings and mappings)
" ============================================================================
" Set colorscheme (syntax highlight), color assignment, and etc.

" Vim colorscheme ------------------------------------------------------------
" Colorschmeme shortcut
nmap <leader>csd :colorscheme default<CR>
nmap <leader>csg :colorscheme gruvbox<CR>
nmap <leader>csv :colorscheme vim-monokai-tasty<CR>
nmap <leader>csw :colorscheme wal<CR>
" Use either 'koehler' or 'elflord' for 'fortran' syntax support
autocmd FileType fortran colorscheme koehler
" Customized colorscheme settings
if using_customized_theme
    if using_wal_theme
        " Option 1 - Direct read Xcolor from wal
        "source $HOME/.cache/wal/colors-wal.vim
        " Option 2 - Use wal vim plugin
        colorscheme wal
    else
        colorscheme vim-monokai-tasty
    endif
    " Common background setting (transparent background)
    set bg=dark
    " Color setup (hi command must be entered after colorscheme)
    hi Normal                               ctermbg=NONE                        guibg=NONE
    hi LineNr       cterm=bold ctermfg=8    ctermbg=NONE gui=bold guifg=#808080 guibg=NONE
    hi CursorLineNr cterm=bold ctermfg=10   ctermbg=NONE gui=bold guifg=#00ff00 guibg=NONE
    hi Pmenu        cterm=bold ctermfg=8    ctermbg=NONE gui=bold guifg=#808080 guibg=NONE
    hi CursorColumn cterm=none ctermfg=none ctermbg=233
    hi CursorLine   cterm=none ctermfg=none ctermbg=233
endif

" Function - Line length warnings [Must be added after color setup] ----------
" Here adopt default vim-textwidth 78 as maximum line length
highlight OverLength    ctermbg=red  ctermfg=white guibg=#ff0000 guifg=#ffffff
highlight UnlimitLength ctermbg=NONE guibg=NONE
map <F7> :match OverLength /\%79v.\+/<CR>:echo '78 char-bound ON'<CR>
map <leader><F7> :match UnlimitLength /\%79v.\+/<CR>:echo '78 char-bound OFF'<CR>

" Function - Comment highlight -----------------------------------------------
map <F8> :hi Comment ctermfg=14 guifg=#00ffff<CR>:echo 'Hi-Comment ON'<CR>
map <leader><F8> :hi Comment ctermfg=8 guifg=#8a8a8a<CR>:echo 'Hi-Comment OFF'<CR>

" ============================================================================
" End of Vim configuration, automatically reload current config after saving
" ============================================================================
" Automated run vim configuration file just after saving ---------------------
"autocmd BufWritePost $MYVIMRC source $MYVIMRC"
