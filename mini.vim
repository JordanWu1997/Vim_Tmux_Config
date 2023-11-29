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
