" ~/.vimrc

" Note: For +clipboard support
" - sudo apt install vim-gtk3
" Note: keyboard settings
" - setxkbmap -option 'ctrl:nocaps'; xset r rate 300 40

" Tab
set expandtab                      " Expand tab to spaces
set tabstop=4                      " Number of space that tab in the file countss
set shiftwidth=4                   " Number of space of auto-indent length
set softtabstop=-1                 " Negative value -> adopt shiftwidth value
" Clipboard
set clipboard^=unnamed,unnamedplus " Copy to system clipboard
" Misc
set number                         " Show line number
set hlsearch                       " Highlight search result
set incsearch                      " Incremental search
set hidden                         " Switch buffers without saving

" Undo
if has('nvim')
    " Directory to place swap files
    set directory=~/.config/nvim/dirs/tmp
    " Make backup files
    set backup
    " Where to put backup files
    set backupdir=~/.config/nvim/dirs/backups
    " Persistent undoes - undo after re-opening
    set undofile
    set undodir=~/.config/nvim/dirs/undos
    set viminfo+=n~/.config/nvim/dirs/viminfo
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
    set viminfo+=n~/.vim/dirs/viminfo
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
