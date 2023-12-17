" ========================================================================== "
" My minimal cross-platfrom vim config for normal usage and python coding    "
" ========================================================================== "
"
" Note: Vim installation with clipboard support (+clipboard)
" - UNIX-like: sudo apt install vim-gtk3
" - Windows: https://www.vim.org/download.php#pc
"
" Note: Location for this configuration file (you also need to rename it ...)
" - UNIX-like: $HOME/.vimrc (e.g. /home/admin/.vimrc)
" - Windows: %USERPROFILE%\_vimrc (e.g. C:\Users\Administrator\_vimrc)
"
" Note: Keyboard settings for mapping capslock to ctrl and speeding up repeat key
" - UNIX-like: setxkbmap -option 'ctrl:nocaps'; xset r rate 300 40

" Load GVim configs on Windows
if has('win32') || has('win64') || has('win16')
    source $VIMRUNTIME/../_vimrc
endif

" Vim settings
set backspace=2                    " Make backspace work like most other programs
set clipboard^=unnamed,unnamedplus " Copy selection to system clipboard
set cursorline                     " Show horizontal line
set encoding=utf-8                 " Use unicode encoding
set expandtab                      " Expand tab to spaces
set exrc                           " Use local vimrc file
set hidden                         " Switch focus between buffers without saving
set hlsearch                       " Highlight search result
set incsearch                      " Incremental search
set modifiable                     " Make current buffer modifiable
set nocompatible                   " Set to be not compatible with ancient vi
set nowrap                         " Line wrap for small monitor or display window
set number                         " Show line number
set shiftwidth=4                   " Number of space of auto-indent length
set showcmd                        " Show entered commands
set softtabstop=-1                 " Negative value -> adopt shiftwidth value
set splitbelow                     " New hsplit pane spawn at the bottom
set splitright                     " New vsplit pane spawn on the right
set tabstop=4                      " Number of space that tab in the file countss
set ttyfast                        " Faster redrawing
set wildmenu                       " Show menu options

" Hidden characters
set nolist                         " Don't show hidden characters
set listchars=eol:↵,tab:»·,trail:╳,extends:»,precedes:«,nbsp:␣

" Ctags
set tags=./.tags,.tags;/           " use ctag -o .tags -R . to generate file tags

" Tmp/Backup/Undo for Windows system
if has('win32') || has('win64') || has('win16')
    " Directory to place swap files
    set directory=%USERPROFILE%\.vim\dirs\tmp
    " Make backup files
    set backup
    " Where to put backup files
    set backupdir=%USERPROFILE%\.vim\dirs\backups
    " Persistent undoes - undo after re-opening
    set undofile
    set undodir=%USERPROFILE%\.vim\dirs\undos
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

" Filetype settings
filetype plugin indent on

" Python completion (w/o ALE)
"autocmd FileType python set omnifunc=python3complete#Complete

" Python completion (w/ ALE)
" - ALE installation
"   - mkdir -p ~/.vim/pack/git-plugins/start; git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
" - Python packages for completion
"   - pip install python-lsp-server yapf isort mypy
set omnifunc=ale#completion#OmniFunc
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['yapf', 'isort'],
\}
let g:ale_linters = {
    \ 'python': ['pylsp', 'mypy']
\}
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
autocmd FileType python nmap K :ALEHover<CR>
autocmd FileType python nmap gK :ALEGoToDefinition<CR>
