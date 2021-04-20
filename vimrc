" .vimrc
" ============================================================================
" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" Modified version: 8.2  by Kuan-Hsien Wu, Sheng-Jun Lin
" ============================================================================
" This vim configuration is for both vim and neovim
" Notes:
" Vim / Neovim configuration file --------------------------------------------
" Vim configuration file
" -- Store in ~/.vimrc
" Neovim configuration file
" -- Store in ~/.config/nvim/init.vim

" Notes:
" Backup of old vim-powerline installation [Not use anymore, use lightline now]
" Powerline-status -----------------------------------------------------------
" " (1) sudo intall vim-powerline (Fedora)
" " (2) sudo apt-get install powerline (Ubuntu)
" " (3) activate manually
" "   -- python3 from powerline.vim import setup as powerline_setup
" "   -- python3 powerline_setup()
" "   -- python3 del powerline_setup

" Notes:
" For special character support
" NERDFont Installation ------------------------------------------------------
" " (1) mkdir -p ~/.local/share/fonts
" " (2) cd ~/.local/share/fonts && curl -fLo \
"       "Droid Sans Mono for Powerline Nerd Font Complete.otf" \
"       https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/\
"       DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

" Notes:
" Vim-Plugin Support ---------------------------------------------------------
" -- If curl is installed, vim-plug (vim-plugin manger) should automatically
"    run all installaion at your first time loading vim.
" -- If vim-plug somehow not working automatically or if you want mannual
"
"    installation, in vim command mode, type :PlugInstall

" Notes:
" Vim-Features Support -------------------------------------------------------
" -- In Fedora, vim is complied without clipboard and python3/dyn features,
" -- For those feature support, you can try either recomplie vim from source
"    codes or [Recommended] just install gvim (gui-vim) from Fedora instead.

" Notes:
" Leaderkey Delay Solution ---------------------------------------------------
" -- In the following configuration, I use space as leaderkey, however, it
"    will encounter delay problem in insert mode (Need wait for a little bit
"    time to enter space character). There are two solutions: One is to set
"    leaderkey to other key than space; The other one (Recommended) is to
"    remap all keymaps that start with space in insert mode (which you can
"    search in vim by command :inoremap)

" Notes:
" Neoformat (Formatter) ------------------------------------------------------
" Call multi-language code formatter [formatter need to be installed ]
" For code formatter support: https://github.com/sbdchd/neoformat
" Example: python code formatter
" -- pip install yapf                  # Install formatter
" -- In vim, :Neoformat! python yapf   # Format with yapf formatter

" ============================================================================
" Vim and Neovim settings
" ============================================================================
" Enable/Disable Vim-plug

" Use vim or neovim (Auto-detect)
let using_neovim = has('nvim')
let using_vim = !using_neovim
" Vim >= 8.0 (Assign 0 to disable)
" Disable this for remote machine that vim <= 8.0 (e.g. Zeus, Fomalhaut)
let using_vim8 = 1
" Vim >= 8.0 can call termininal inside vim (But very time-consuming)
let using_customized_terminal = 0
" Customize vim theme (Assing 0 to disable)
let using_customized_theme = 1
" Fancy symbols (Assign 0 to disable)
" Mainly affect to Nertree and Lightline
let using_fancy_symbols = 1
" Extra vim-plug (Assing 0 to disable)
let using_extra_plug = 1
" Coding tools vim-plug (Assing 0 to disable)
let using_coding_tool_plug = 1
" Python Completion (Assing 0 to disable)
let using_python_completion = 0
autocmd FileType python let using_python_completion = 1

" ============================================================================
" Vim built-in function settings and Vim hotkeys settings
" ============================================================================
" All parameter settings and hotkey mappings

" Set leaderkey --------------------------------------------------------------
let mapleader = ' '

" Map insert mode Esc key ----------------------------------------------------
" - Use Ctrl+v to escape
inoremap ii <Esc>
inoremap kj <Esc>
inoremap jk <Esc>

" Beginning/End, PageUp/PageDown ---------------------------------------------
map <leader>b 0
map <leader>s ^
map <leader>e $

" Save/Load file hotkey ------------------------------------------------------
" - ZZ (Quit and save if there's change in file)
" - :f <new-filename> (Save current file with new filename)
map <leader>q  :q<CR>
map <leader>qa :qa<CR>
map <leader>Q  :q!<CR>
map <leader>Qa :qa!<CR>
map <leader>w  :w<CR>
map <leader>wq :wq<CR>
map <leader>Wq :wa<CR>:q<CR>
map <leader>WQ :wa<CR>:qa<CR>
" Overwrite (Not working for now, use plug-in suda.vim instead)
"command! Sudow execute 'w !sudo -S tee % > /dev/null'

" Shell command --------------------------------------------------------------
" -- :r !date (Insert timestamp)
" -- :K (Manpage for current selected word)
map <leader>m :Man<space>

" Vim built-in setting -------------------------------------------------------
filetype on
" Following settings are automatically executed by VIM-plug
"filetype plugin on
"filetype indent on
"syntax enable

" Vim window/pane/fold configuration -----------------------------------------
nnoremap <silent><leader>sv :mkview<CR>:echo 'Setting Saved ...'<CR>
nnoremap <silent><leader>ld :loadview<CR>:echo 'Setting Loaded ...'<CR>

" Vim split window (pane) control --------------------------------------------
" Split pane - more natural split opening
set splitbelow
set splitright
" Split pane navigation
" [Also integrate with tmux now, check vim-tmux-navigator]
nnoremap <silent><leader>; <C-W><C-W>
nnoremap <silent><leader>h :wincmd h<CR>
nnoremap <silent><leader>j :wincmd j<CR>
nnoremap <silent><leader>k :wincmd k<CR>
nnoremap <silent><leader>l :wincmd l<CR>
nnoremap <silent><leader><Left>  :wincmd h<CR>
nnoremap <silent><leader><Down>  :wincmd j<CR>
nnoremap <silent><leader><Up>    :wincmd k<CR>
nnoremap <silent><leader><Right> :wincmd l<CR>
" Split pane location swap
nnoremap <silent><leader>H :wincmd H<CR>
nnoremap <silent><leader>J :wincmd J<CR>
nnoremap <silent><leader>K :wincmd K<CR>
nnoremap <silent><leader>L :wincmd L<CR>
" Split pane resize
nnoremap <silent><leader>. :vertical resize +5<CR>
nnoremap <silent><leader>, :vertical resize -5<CR>
nnoremap <silent><leader>> :vertical resize +20<CR>
nnoremap <silent><leader>< :vertical resize -20<CR>
nnoremap <silent><leader>- :resize +5<CR>
nnoremap <silent><leader>= :resize -5<CR>
nnoremap <silent><leader>_ :resize +20<CR>
nnoremap <silent><leader>+ :resize -20<CR>
nnoremap <silent><leader>== :wincmd =<CR>
nnoremap <silent><leader>++ :wincmd =<CR>
" Split pane action
nnoremap <silent><leader>wt :wincmd T<CR>
nnoremap <silent><leader>wc :wincmd c<CR>
nnoremap <leader>wn :wincmd n<CR>
nnoremap <leader>wx :split<space>
nnoremap <leader>wv :vsplit<space>
nnoremap <leader>wX :split<CR>
nnoremap <leader>wV :vsplit<CR>

" Vim settings ---------------------------------------------------------------
set nocompatible          " Not compatible with traditional vi
set confirm               " Ask for confirmation before leaving vim
set ignorecase            " Ignore upper/lower case when searching
set modifiable            " Make editing buffer modifable
set encoding=utf-8        " Unicode display
set clipboard=unnamedplus " Shared system clipboard, gvim must be installed

" Line wrap ------------------------------------------------------------------
set wrap                  " Line wrap for small monitor or display window
noremap <leader>wp :set wrap!<CR>:echo 'Toggle Line Wrap'<CR>

" Comment  highlight ---------------------------------------------------------
"noremap <F8> :hi Comment ctermfg=14 guifg=#00ffff<CR>:echo 'Hi-Comment ON'<CR>
noremap <F8> :hi Comment ctermfg=10 guifg=#5fff5f<CR>:echo 'Hi-Comment ON'<CR>
noremap <leader><F8> :hi Comment ctermfg=245 guifg=#8a8a8a<CR>:echo 'Hi-Comment OFF'<CR>

" Wild menu settings ---------------------------------------------------------
set wildmenu              " Show memu options
set wildmode=list:full    " Show all available input options

" Cursor settings ------------------------------------------------------------
set ruler                 " Show cursor position in statusline
set cursorline            " Show vertical line
set cursorcolumn          " Show horizontal line

" Search settings ------------------------------------------------------------
set incsearch
set hlsearch
map <leader>/ :set nohlsearch<CR>:echo 'Disable Search Highlight'<CR>
map <leader>? :set hlsearch<CR>:echo 'Enable Search Highlight'<CR>

" Line number settings -------------------------------------------------------
set number
set relativenumber
inoremap <F5> <Esc>:set number!<CR>:echo 'Toggle Line Number'<CR>i
inoremap <F6> <Esc>:set relativenumber!<CR>:echo 'Toggle Rel Line Number'<CR>i
nnoremap <F5> :set number!<CR>:echo 'Toggle Line Number'<CR>
nnoremap <F6> :set relativenumber!<CR>:echo 'Toggle Rel Line Number'<CR>
nnoremap <leader><F5> :set number!<CR>:echo 'Toggle Line Number'<CR>
nnoremap <leader><F6> :set relativenumber!<CR>:echo 'Toggle Rel Line Number'<CR>

" Fold Setting ---------------------------------------------------------------
set nofoldenable
set foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
nnoremap <silent><leader>ff za<CR>:echo 'Toggle Current Fold...'<CR>
nnoremap <silent><leader>cf zM<CR>:echo 'Close All Folds ...'<CR>
nnoremap <silent><leader>of zR<CR>:echo 'Open All Folds ...'<CR>

" Tabe (Window) Setting ------------------------------------------------------
" Tabe (Window) operations
map <leader>ts :tabs<CR>
map <leader>tt :tabnew<space>
map <leader>td :tabclose<space>
map <silent><leader>tdd :tabclose<CR>:echo 'CLOSE CURRENT TAB ...'<CR>
" Tabe (Window) navigation
map <tab>p :tabprevious<CR>:echo 'PREVIOUS TAB'<CR>
map <tab>n :tabnext<CR>:echo 'NEXT TAB'<CR>
map <silent><C-Left>  :tabprevious<CR>:echo 'PREVIOUS TAB ...'<CR>
map <silent><C-Right> :tabnext<CR>:echo 'NEXT TAB ...'<CR>
map <silent><F2> <Esc>:tabnext<CR>:echo 'NEXT TAB ...'<CR>
map <silent><leader><F2> <Esc>:tabprevious<CR>:echo 'PREVIOUS TAB ...'<CR>
" Tabe (Window) swap
map <silent><A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
map <silent><A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Buffer Setting -------------------------------------------------------------
" -- Reference: https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
" -- Useful command: ':e#' or 'Ctrl-^' to edit between two buffers
" -- A buffer becomes hidden when it is abandoned
set hidden
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
" Buffer key mappings
map <silent><leader>ls :ls<CR>
map <silent><leader>bs :buffers<CR>
map <leader>b :b<space>
map <leader>bb :edit<space>
map <leader>ba :badd<space>
map <leader>bd :bdelete<space>
map <silent><leader>dd :bdelete<CR>:echo 'DELETE CURRENT BUFFER [PRESS CTRL+O TO RECOVER]'<CR>
map <silent><leader>bdd :bdelete<CR>:echo 'DELETE CURRENT BUFFER ...'<CR>
map <silent><leader><F1> <Esc>:bp<CR>:echo 'PREVIOUS BUFFER ...'<CR>
map <silent><F1> <Esc>:bn<CR>:echo 'NEXT BUFFER ...'<CR>

" Marks Setting --------------------------------------------------------------
map <leader>md :delmarks<space>

" Registers Setting ----------------------------------------------------------
" Show registers in vim
map <leader>re :registers<CR>

" Display --------------------------------------------------------------------
" When scrolling, keep cursor N lines away from screen border
set scrolloff=3                   " Keep cursor 3 lines away from bottom
set display+=lastline             " Show line as much as possible
set title                         " Let vim change terminal title

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

" No system bell -------------------------------------------------------------
set visualbell    " ┐
set noerrorbells  " │ Disable beeping and window flashing
set t_vb=         " ┘ https://vim.wikia.com/wiki/Disable_beeping

" Function - Autoremove white space in end of line ---------------------------
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
" Remove trailing white space for python codes
autocmd BufWritePre *.py call RemoveTrailingWhitespace()
nmap <leader>rm :call RemoveTrailingWhitespace()<CR>:echo "Remove Tail Whitespaces"<CR>

" Function - Foldcolumn display ----------------------------------------------
noremap <F7> :set foldcolumn=6<CR>:echo 'Foldcolumn ON'<CR>
noremap <leader><F7> :set foldcolumn=0<CR>:echo 'Foldcolumn OFF'<CR>

" Terminal Mode - Open terminal in vim buffer --------------------------------
" -- Enter insert mode to use terminal command line
" -- In terminal buffer, <C-\><C-n> back to normal mode

" Set terminal shell
if using_vim8 && using_customized_terminal
    " Set terminal shell inside vim
    set shell=/bin/fish
    " Open terminal buffer
    if using_neovim
        map <F10> :split<CR>:resize -5<CR>:term<CR>:echo 'Open Terminal'<CR>
    else
        map <F10> :below terminal<CR>
    endif
    " Map key to go back from terminal mode to normal mode
    " Do not use Esc (which conflicts with fzf window)
    tnoremap <leader><F10> <C-\><C-n>:echo 'Back to Normal Mode'<CR>
    tnoremap kj <C-\><C-n>:echo 'Back to Normal Mode'<CR>
endif

" Ability to add python breakpoints ------------------------------------------
" # ipdb must be installed first
" -- In termianl: run 'pip install ipdb'
autocmd FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

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
    "Plug 'morhetz/gruvbox'
    " Lightline (status line)
    Plug 'itchyny/lightline.vim'
    " Lightline bufferline
    Plug 'mengelbrecht/lightline-bufferline'
endif

" [File/Code Browsing] -------------------------------------------------------
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" File browser [Support netrw (vim built-in file browser) functions]
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'
if using_fancy_symbols
    " Nerdtree and other vim-plug powerline symbols support
    Plug 'ryanoasis/vim-devicons'
    " More highlight in nertree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif
"Class/module browser
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" [Vim useful functions] -----------------------------------------------------
" Vim smooth scroll
Plug 'yuttie/comfortable-motion.vim'
" Sudo write/read files in vim
Plug 'lambdalisue/suda.vim'
"Vim settings for opening large files
Plug 'vim-scripts/LargeFile'
" System Man usage
Plug 'vim-utils/vim-man', { 'on': 'Man' }
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Generate bracket/quotation in pair
Plug 'tpope/vim-surround'
" Vim window maximizer
Plug 't9md/vim-choosewin'
" Auto-pair for quotations and brackets
Plug 'jiangmiao/auto-pairs'

" [Vim extra functions] ------------------------------------------------------
if using_extra_plug
    if using_neovim
        " Override configs by directory [Time-consuming for initialization]
        "Plug 'arielrossanigo/dir-configs-override.vim'
        " Fancy startup page of vim [Not use in vim, too loadtime-consuming]
        Plug 'mhinz/vim-startify'
        " Goyo (Distraction-free mode)
        Plug 'junegunn/goyo.vim'
        " Vim-wiki [Not use in vim]
        Plug 'vimwiki/vimwiki'
    endif
    " History of yank
    Plug 'vim-scripts/YankRing.vim'
    " Easymotion (Key-mapping moving in vim)
    Plug 'easymotion/vim-easymotion'
    " Auto popup completion options from vim
    Plug 'vim-scripts/AutoComplPop'
    " Paint css colors with the real color
    Plug 'lilydjwg/colorizer'
endif

" [Functions for coding] -----------------------------------------------------
if using_coding_tool_plug
    " Languge packs [Not working on fomalhaut (vim=7.0)]
    Plug 'sheerun/vim-polyglot'
    " Multiple language syntax support [Not working on fomalhaut (vim=7.0)]
    Plug 'dense-analysis/ale', { 'for': ['python', 'fortran', 'html'] }
    " Code formatter
    Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
    " Syntax support (Improved syntastics)
    "Plug 'neomake/neomake'
    " Pending tasks list
    Plug 'fisadev/FixedTaskList.vim', { 'on': 'TaskList' }
    " Paint paired bracket/quotation in different color
    Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' }
    " Save last . motion for next time usage
    Plug 'tpope/vim-repeat'
    " Indent line guide [Color column]
    Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }
    " Indent text object (i for indent as w for word)
    Plug 'michaeljsmith/vim-indent-object'
     "Multiple cursor with incsearch support
    Plug 'terryma/vim-multiple-cursors'
    " Git integration
    Plug 'tpope/vim-fugitive', { 'on': 'Git' }
    " Git/mercurial/others diff icons on the side of the file lines
    Plug 'mhinz/vim-signify' ", { 'on': 'SignifyToggle' }
endif

" [Python coding] ------------------------------------------------------------
if using_python_completion
    " Python autocompletion [Not working on Zeus (lack of dependence)]
    if using_neovim && vim_plug_just_installed
        Plug 'Shougo/deoplete.nvim', { 'do': ':autocmd VimEnter * UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim', { 'for': 'python' }
    endif
    " Yet Another Remote Plugin Framework for Neovim [needed for deoplete.nvim]
    " [Not working on Zeus (lack of dependence)]
    Plug 'roxma/nvim-yarp', { 'for': 'python' }
    " Help communicate beteen vim and neovim [needed for deoplete.nvim]
    " [Not working on Zeus (lack of dependence)]
    Plug 'roxma/vim-hug-neovim-rpc', { 'for': 'python' }
    " Python autocompletion [Not working on Zeus (lack of dependence)]
    Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
    " Completion from other opened files [Not working on Zeus (lack of dependence)]
    Plug 'Shougo/context_filetype.vim', { 'for': 'python' }
    " Just to add the python go-to-definition and similar features, autocompletion
    " from this plugin is disabled [Not working on Zeus (lack of dependence)]
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
endif
" More python syntax highlight
Plug 'vim-python/python-syntax', { 'for': 'python' }
" Sort python import (too much time-consuming)
Plug 'fisadev/vim-isort', { 'on': 'Isort', 'for': 'python' }

" [Fortran coding] -----------------------------------------------------------
" Fortran syntax support
Plug 'tomedunn/vim.fortran', { 'for': 'fortran' }

" [Tmux] ---------------------------------------------------------------------
if using_vim8
    "" Share focus between vim and tmux [Needed for clilpboard sharing]
    " [Not working on Zeus]
    Plug 'tmux-plugins/vim-tmux-focus-events'
    " Share clipboard between vim and tmux [Not working on Zeus]
    Plug 'roxma/vim-tmux-clipboard'
endif
" Navigate seamlessly in vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" [HTML coding] --------------------------------------------------------------
if using_vim8
    " Highlight matching html tags
    Plug 'valloric/MatchTagAlways', { 'for': 'html' }
    " Generate html in a simple way
    Plug 'mattn/emmet-vim', { 'for': 'html' }
    " Generate closetag for HTML
    Plug 'alvan/vim-closetag', { 'for': 'html' }
endif

" [Latex] --------------------------------------------------------------------
if using_vim8
    " Latex compiler support
    Plug 'vim-latex/vim-latex', { 'for': 'tex' }
    " Real time Tex -> Pdf file preview
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
endif

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
" Plugins settings and mappings
" ============================================================================
" Edit them as you wish.

" Tab Key Setting [Must be added after vim-plug] -----------------------------
set expandtab        " expand tab to spaces
set tabstop=4        " numbers of space that tab in the file counts
set shiftwidth=4     " number of space of auto-indent length
set softtabstop=-1   " numbers of space that tab while editing
                     " negative value -> adopt shiftwidth value
" PEP8 recommendation for tab settings
autocmd FileType python setlocal et ts=4 sw=4 sts=4
" Makefile not support expand tabs to spaces
autocmd FileType make setlocal noet
"Tab key in all modes
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Lightline ------------------------------------------------------------------
if using_customized_theme
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

" Lightline tabline ----------------------------------------------------------
if using_customized_theme
    let g:lightline#bufferline#show_number  = 0
    let g:lightline#bufferline#shorten_path = 0
    let g:lightline#bufferline#unnamed      = '[No Name]'
    let g:lightline.tabline          = { 'left': [['tabs']], 'right': [['buffers']] }
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

" Tagbar ---------------------------------------------------------------------
" autofocus on tagbar open
let g:tagbar_autofocus = 1
let g:tagbar_map_showproto = 'd'
" toggle tagbar display
map <silent><F4> :TagbarToggle<CR>
map <silent><leader><F4> :TagbarToggle<CR>

" NERDTree -------------------------------------------------------------------
" Disable vim built-in netrw
let loaded_netrwPlugin = 1
" Toggle nerdtree display
map <silent><F3> :NERDTreeToggle<CR>
map <silent><leader><F3> :NERDTreeToggle<CR>
" Open nerdtree with the current file selected
map <silent>,t :NERDTreeFind<CR>
map <leader>pwd :pwd<CR>
" Don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let g:NERDTreeMouseMode = 3
let g:NERDTreeDirArrows = ''
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

" Tasklist -------------------------------------------------------------------
map <leader>tl :TaskList<CR>

" Rainbow parentheses --------------------------------------------------------
" Don;t enable when start up
let g:rainbow_active = 0
nnoremap <leader>rb :RainbowToggle<CR>

" Comfortable motion ---------------------------------------------------------
" Disable default key mapping
let g:comfortable_motion_no_default_key_mappings = 1
" Motion with keyboard and mousewheel 
nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>

" Ale (Syntax check) ---------------------------------------------------------
let g:ale_enabled = 0
nnoremap <leader>al :ALEToggle<CR>

" Python Syntax --------------------------------------------------------------
let g:python_highlight_all = 1

" Fortran --------------------------------------------------------------------
" Ensure correct highlighting for
" Fortran free-form source code and turn syntax highlighting on
let fortran_free_source = 1
let fortran_do_enddo = 1

" LargeFile ------------------------------------------------------------------
" File unit: MB
let g:LargeFile = 10

" Indent Guides --------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 4
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg='#303030' ctermbg=225
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#24242d' ctermbg=194
map <leader>ig :IndentGuidesToggle<CR>:echo 'Toggle Indent Guides'<CR>

" YankRing -------------------------------------------------------------------
if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    " Fix for yankring and neovim problem when system has non-text things
    " copied in clipboard
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif
nmap <leader>ys :YRShow<CR>:echo 'Show Yank History'<CR>

" Auto-pairs -----------------------------------------------------------------
let g:AutoPairsShortcutToggle = '<F9>'

" Surround -------------------------------------------------------------------
" Disable default surround mappings
let g:surround_no_mappings = 1
" d: delete, c: change, y:yield
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap cS <Plug>CSurround
nmap ys <Plug>Ysurround
nmap yS <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround

" fzf.vim --------------------------------------------------------------------
" Caution:
"   - ripgrep must be installed if Rg function is needed
"   - if syntax highlight is needed, please install bat from command line

" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
" Default fzf layout (Floating in the center of window)
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
" fzf key mapping
nnoremap <leader>bf :Buffers<CR>
nnoremap <leader>fs :Files<space>
nnoremap <leader>lc :Locate<space>
nnoremap <leader>rg :Rg<space>
nnoremap <leader>ln :Lines<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>tg :Tags<CR>
nnoremap <leader>bg :BTags<CR>
nnoremap <leader>hs :History<CR>
nnoremap <leader>h: :History:<CR>
nnoremap <leader>h/ :History/<CR>
nnoremap <leader>mk :Marks<CR>
nnoremap <leader>ds :Windows<CR>
nnoremap <leader>ft :Filetypes<CR>
nnoremap <leader>cd :Commands<CR>
nnoremap <leader>nm :Maps<CR>
nnoremap <leader>ht :Helptags<CR>
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
" Word completion with custom spec with popup layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

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
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>h <Plug>(easymotion-linebackward)
map <leader><leader>1 <Plug>(easymotion-overwin-f)
map <leader><leader>2 <Plug>(easymotion-overwin-f2)

" Multiple-cursors -----------------------------------------------------------
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<S-j>'
let g:multi_cursor_select_all_word_key = '<S-m>'
let g:multi_cursor_next_key            = '<S-j>'
let g:multi_cursor_prev_key            = '<S-k>'
let g:multi_cursor_skip_key            = '<S-o>'
let g:multi_cursor_quit_key            = '<Esc>'

" Window-chooser -------------------------------------------------------------
nmap  <leader><Enter> <Plug>(choosewin)
" Show big letters
let g:choosewin_overlay_enable = 1

" Vim maximizer --------------------------------------------------------------
" Default mapping is <F3> (Disabled now)
let g:maximizer_set_default_mapping = 0
nnoremap <silent><leader>z :MaximizerToggle<CR>
vnoremap <silent><leader>z :MaximizerToggle<CR>gv

" Signify --------------------------------------------------------------------
" This first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" Mappings to jump to changed blocks
nmap <leader>st :SignifyToggle<CR>
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" Nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

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
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
inoremap <expr><tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><C-k>   pumvisible() ? "\<c-p>" : "\<C-k>"
inoremap <expr><C-j>   pumvisible() ? "\<c-n>" : "\<C-j>"
inoremap <expr><C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr><C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Deoplete -------------------------------------------------------------------
if using_python_completion
    " [Not working on Zeus (lack of dependence)]
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
if using_python_completion
    " [Not working on Zeus (lack of dependence)]
    " Disable autocompletion (using deoplete instead)
    let g:jedi#completions_enabled = 0
    " All these mappings work only for python code:
    " Go to definition
    let g:jedi#goto_command = ',d'
    " Find ocurrences
    let g:jedi#usages_command = ',o'
    " Find assignments
    let g:jedi#goto_assignments_command = ',a'
    " Go to definition in new tab
    nmap ,D :tab split<CR>:call jedi#goto()<CR>
endif

" Vim-Wiki -------------------------------------------------------------------
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Colorscheme ----------------------------------------------------------------
if using_customized_theme
    "colorscheme gruvbox
    colorscheme vim-monokai-tasty
    " Use either 'koehler' or 'elflord' for 'fortran' syntax support
    autocmd FileType fortran colorscheme koehler
    " Common Background Setting (Transparent Background)
    " hi command must be entered after colorscheme
    set bg=dark
    hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE gui=bold guifg=#808080 guibg=NONE
    hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE gui=bold guifg=#00ff00 guibg=NONE
    hi Normal guibg=NONE ctermbg=NONE
endif

" TERM GUI color -------------------------------------------------------------
" Require terminal realcolor (transparent not working on remote terminal)
if has('termguicolors')
    set termguicolors
endif
" 256 term color support in vim TUI
if !has('gui_running')
    set t_Co=256
endif

" Function - Line length warnings [ Must be added after color setup ] --------
" Here adopt default vim-textwidth 78 as maximum line length
highlight OverLength ctermbg=red ctermfg=white guibg=#ff0000 guifg=#ffffff
highlight UnlimitLength ctermbg=NONE guibg=NONE
nnoremap <leader>wo :match OverLength /\%79v.\+/<CR>:echo '78 char-bound ON'<CR>
nnoremap <leader>wf :match UnlimitLength /\%79v.\+/<CR>:echo '78 char-bound OFF'<CR>

" Vim-LaTex viewer -----------------------------------------------------------
if using_vim8
    let g:livepreview_previwer = 'okular'
    let g:livepreview_engine = 'pdflatex'
    autocmd FileType tex setlocal spell
    autocmd FileType tex setl updatetime=10000 " Unit: milisecond
    autocmd FileType tex map <F3> :LLPStartPreview<CR>
endif

" Function - Markdown viewer -------------------------------------------------
" From https://krehwell.com/blog/Open%20Markdown%20Previewer%20Through%20Vim
if using_vim8
    let $VIMBROWSER='google-chrome'
    let $OPENBROWSER='nnoremap <F3> :!'. $VIMBROWSER .' %:p &<CR>'
    augroup OpenMdFile
        autocmd!
        autocmd BufEnter *.md echom 'Press F3 to Open .md File'
        autocmd BufEnter *.md exe $OPENBROWSER
    augroup END
endif

" Function - Hex editor ------------------------------------------------------
" From https://blog.gtwang.org/useful-tools/how-to-use-vim-as-a-hex-editor/
map <leader>ho :%! xxd<CR>:echo 'Hex editor on: TF to binary data'<CR>
map <leader>hf :%! xxd -r<CR>:echo 'Hex editor off: TF to original data'<CR>

" ============================================================================
" End of Vim configuration, automatically reload current config after saving
" ============================================================================
" Automated run vim configuration file just after saving ---------------------
"autocmd BufWritePost $MYVIMRC source $MYVIMRC
