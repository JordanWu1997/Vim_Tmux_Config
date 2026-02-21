" ~/.vimrc
" vim: ft=vim
" ============================================================================
" My minimal cross-platfrom vim config for normal usage and python coding
" ============================================================================
"
" NOTE: Vim installation with clipboard support (+clipboard)
" - UNIX-like: sudo apt install vim-gtk3
" - Windows: https://www.vim.org/download.php#pc
"
" NOTE: Location for this configuration file (you also need to rename it ...)
" - UNIX-like: $HOME/.vimrc (e.g. /home/admin/.vimrc)
" - Windows: %USERPROFILE%\_vimrc (e.g. C:\Users\Administrator\_vimrc)
"
" NOTE: Keyboard settings for mapping capslock to ctrl and speeding up repeat key
" - UNIX-like: setxkbmap -option 'ctrl:nocaps'; xset r rate 300 40

" ============================================================================
" Basic settings
" ============================================================================

" Load GVim configs on Windows
if has('win32') || has('win64') || has('win16')
    source $VIMRUNTIME/../_vimrc
endif

" Vim settings
set backspace=2                    " Make backspace work like most other programs
set clipboard^=unnamed,unnamedplus " Copy selection to system clipboard
set cursorline                     " Show horizontal line
set encoding=utf-8                 " Use unicode encoding
set exrc                           " Use local vimrc file
set hidden                         " Switch focus between buffers without saving
set modifiable                     " Make current buffer modifiable
set nocompatible                   " Set to be not compatible with ancient vi
set wrap                           " Line wrap for small monitor or display window
set number                         " Show line number
set showcmd                        " Show entered commands
set splitbelow                     " New hsplit pane spawn at the bottom
set splitright                     " New vsplit pane spawn on the right
set ttyfast                        " Faster redrawing
set wildmenu                       " Show menu options
set virtualedit=none               " Cursor can only be positioned where there is a char

" Tab
set expandtab                      " Expand tab to spaces
set shiftwidth=4                   " Number of space of auto-indent length
set softtabstop=-1                 " Negative value -> adopt shiftwidth value
set tabstop=4                      " Number of space that tab in the file countss

" Search
set hlsearch                       " Highlight search result
set ignorecase                     " Close case sensitive [Needed for smartcase]
set incsearch                      " Incremental search
set smartcase                      " Case sensitive if search contains uppercase letter

" Fold
set nofoldenable                   " Do not enable fold
set foldmethod=indent              " Set fold method to indent

" Cursor
let &t_EI="\e[2 q"                 " Blinking bar in insert/replace mode
let &t_SI="\e[6 q"                 " Blinking block in normal/visual mode

" Hidden characters
set list                           " Show hidden characters
set listchars=eol:↵,tab:»·,trail:╳,extends:»,precedes:«,nbsp:␣

" Ctags
set tags=./.tags,.tags;/           " use ctag -o .tags -R . to generate file tags

" Python3 host (for ALE)
let g:python3_host_prog = '/usr/bin/python' "$CONDA_PYTHON_EXE

" ============================================================================
" Backup settings
" ============================================================================

" Tmp/Backup/Undo for Windows system
if has('win32') || has('win64') || has('win16')
    " Directory to place swap files
    set directory=%USERPROFILE%\vimfiles\dirs\tmp
    " Make backup files
    set backup
    " Where to put backup files
    set backupdir=%USERPROFILE%\vimfiles\dirs\backups
    " Persistent undoes - undo after re-opening
    set undofile
    set undodir=%USERPROFILE%\vimfiles\dirs\undos

" Tmp/Backup/Undo for UNIX-like system
else
    " Directory to place swap files
    set directory=~/.vim/dirs/tmp
    " Make backup files
    set backup
    " Where to put backup files
    set backupdir=~/.vim/dirs/backups
    " Persistent undoes - undo after re-opening
    set undofile
    set undodir=~/.vim/dirs/undos
endif

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

" ============================================================================
" Keybindings
" ============================================================================

" Leader key
let mapleader = ' '

" Easier keybinding for Escape
inoremap kj <Esc>

" Add break point for text-writing undo
" e.g. w/o bp: test,test,test --undo->
" e.g. w/i bp: test,test,test --undo-> test,test,
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u

" Make Y yank to the EOL instead of whole line just like what D does
nnoremap Y y$

" Move selection block up/down in visual mode
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" W command: write with sudo permission
command! W silent execute 'w !sudo tee ' . shellescape(expand('%')) . ' > /dev/null' | edit!

" ============================================================================
" Filetype settings
" ============================================================================

" Filetype settings
filetype plugin indent on

" Python completion (w/o ALE)
autocmd FileType python set omnifunc=python3complete#Complete

" ============================================================================
" Plug-in settings
" ============================================================================

" Vim-Tmux-Navigator
if !has('win32')
    let vim_plug_path = expand('~/.vim/pack/git-plugins/start/vim-tmux-navigator/vim-tmux-navigator.tmux')
    if !filereadable(vim_plug_path)
        echo 'Installing Vim-Tmux-Navigator ...'
        echo ''
        silent !mkdir -p ~/.vim/pack/git-plugins/start
        silent !git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/git-plugins/start/vim-tmux-navigator
    endif
endif

" ALE (Asynchronous Lint Engine)
if has('win32')
    let home = expand('$HOME')
    let s:vim_ALE_config_path = home . '\_mini_ALE.vim'
    if filereadable(s:vim_ALE_config_path)
        exec 'source ' . s:vim_ALE_config_path
    endif
else
    let s:vim_ALE_config_path = expand('~/.mini_ALE.vim')
    if filereadable(s:vim_ALE_config_path)
        exec 'source ' . s:vim_ALE_config_path
    endif
endif

" AI Assistant w/ Ollama
if has('win32')
    let home = expand('$HOME')
    let s:vim_AI_config_path = home . '\_mini_AI.vim'
    if filereadable(s:vim_AI_config_path)
        exec 'source ' . s:vim_AI_config_path
    endif
else
    let s:vim_AI_config_path = expand('~/.mini_AI.vim')
    if filereadable(s:vim_AI_config_path)
        exec 'source ' . s:vim_AI_config_path
    endif
endif
