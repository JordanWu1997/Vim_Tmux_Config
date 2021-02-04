" .vimrc
" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" Modified version: 8.2  by Sheng-Jun Lin, Kuan-Hsien Wu

" =============================================================================
" Vim built-in function settings and Vim hotkeys settings
" =============================================================================
" All parameter settings and hotkey mapping

" TERM GUI color --------------------------------------------------------------
" require terminal color (transparent not working on remote terminal)
" comment below line if color is not support for terminal
set termguicolors

" Set leaderkey ---------------------------------------------------------------
let mapleader = ' '

" map insert mode Esc key -----------------------------------------------------
inoremap jk <Esc>
inoremap kj <Esc>

" Shell command ---------------------------------------------------------------
map <C-c> :!
imap <C-c> :!
map cht :!curl cht.sh/
map <leader>m :Man<space>

" VIM built-in setting --------------------------------------------------------
syntax enable
filetype on
filetype plugin on

" Beginning/End, PageUp/PageDown ----------------------------------------------
map <leader>b 0
map <leader>e $
map <leader>d <PageDown>
map <leader>u <PageUp>

" Save/Load file hotkey -------------------------------------------------------
map <leader>q :q<CR>
map <leader>qa :qa<CR>
map <leader>Q :q!<CR>
map <leader>Qa :qa!<CR>
map <leader>w :w<CR>
map <leader>wq :wq<CR>
map <leader>Wq :wa<CR>:q<CR>
map <leader>WQ :wa<CR>:qa<CR>

" VIM window control ----------------------------------------------------------
nnoremap <silent><leader>; <C-W><C-W>
nnoremap <silent><leader>h <C-W>h
nnoremap <silent><leader>j <C-W>j
nnoremap <silent><leader>k <C-W>k
nnoremap <silent><leader>l <C-W>l
nnoremap <silent><leader><Left> <C-W>h
nnoremap <silent><leader><Down> <C-W>j
nnoremap <silent><leader><Up> <C-W>k
nnoremap <silent><leader><Right> <C-W>l
nnoremap <silent><leader>H <C-W>H
nnoremap <silent><leader>J <C-W>J
nnoremap <silent><leader>K <C-W>K
nnoremap <silent><leader>L <C-W>L
nnoremap <silent><leader>. :vertical resize +5<CR>
nnoremap <silent><leader>, :vertical resize -5<CR>
nnoremap <silent><leader>> :vertical resize +20<CR>
nnoremap <silent><leader>< :vertical resize -20<CR>
nnoremap <silent><leader>- :resize +5<CR>
nnoremap <silent><leader>= :resize -5<CR>
nnoremap <silent><leader>_ :resize +20<CR>
nnoremap <silent><leader>+ :resize -20<CR>
nnoremap <silent><leader>== <C-W>=
nnoremap <silent><leader>++ <C-W>=

" VIM settings ----------------------------------------------------------------
set confirm
set incsearch
set ignorecase
set nocompatible
set nostartofline
set noshowmode "no vim-built-in statusline
set wildmenu "show memu options
set clipboard=unnamedplus

" Comment  highlight ----------------------------------------------------------
noremap <F8> :hi Comment ctermfg=14 guifg=#00ffff<CR>:echo 'Hi-Comment ON'<CR>
noremap <leader><F8> :hi Comment ctermfg=245 guifg=#8a8a8a<CR>:echo 'Hi-Comment OFF'<CR>

" Search settings -------------------------------------------------------------
set ruler
set cursorline
set cursorcolumn
set hlsearch
map <leader>hl :set hlsearch!<CR>:echo 'Toggle Highlight'<CR>

" Line number settings --------------------------------------------------------
set number
set relativenumber
nnoremap <F5> :set number!<CR>:echo 'Toggle Line Number'<CR>
nnoremap <F6> :set relativenumber!<CR>:echo 'Toggle Rel Line Number'<CR>
nnoremap <leader><F5> :set number!<CR>:echo 'Toggle Line Number'<CR>
nnoremap <leader><F6> :set relativenumber!<CR>:echo 'Toggle Rel Line Number'<CR>
inoremap <leader><F5> <Esc>:set number!<CR>:echo 'Toggle Line Number'<CR>i
inoremap <leader><F6> <Esc>:set relativenumber!<CR>:echo 'Toggle Rel Line Number'<CR>i

" Fold Setting ----------------------------------------------------------------
set nofoldenable
set foldmethod=indent
"set foldmethod=syntax
nnoremap <leader>mk :mkview<CR>:echo 'Setting Saved ...'<CR>
nnoremap <leader>ld :loadview<CR>:echo 'Setting Loaded ...'<CR>
nnoremap <leader>ff za<CR>:echo 'Toggle Current Fold...'<CR>
nnoremap <leader>cf zM<CR>:echo 'Close All Folds ...'<CR>
nnoremap <leader>of zR<CR>:echo 'Open All Folds ...'<CR>

" Tab Setting -----------------------------------------------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
filetype plugin indent on
autocmd FileType python setlocal et ts=4 sw=4 sts=4
map <tab>p :tabprevious<CR>:echo 'PREVIOUS TAB'<CR>
map <tab>n :tabnext<CR>:echo 'NEXT TAB'<CR>
map <silent><C-Left> :tabprevious<CR>
map <silent><C-Right> :tabnext<CR>
map <silent><A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
map <silent><A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
map <leader><F1> <Esc>:tabprevious<CR>:echo 'PREVIOUS TAB'<CR>
map <F1> <Esc>:tabnext<CR>:echo 'NEXT TAB'<CR>
map <leader>ts :tabs<CR>
map <leader>tt :tabnew<space>
map <leader>T :tabclose<space>
map <leader>TT :tabclose<CR>:echo 'CLOSE CURRENT TAB'<CR>

" Buffer Setting --------------------------------------------------------------
set hidden
map ls :ls<CR>
map ed :edit<space>
map bf :buffer<space>
map bs :buffers<CR>
map ba :badd<space>
map bd :bdelete<space>
map bdd :bdelete<CR>:echo 'DELETE CURRENT BUFFER'<CR>
map <leader><F2> <Esc>:bp<CR>:echo 'PREVIOUS BUFFER'<CR>
map <F2> <Esc>:bn<CR>:echo 'NEXT BUFFER'<CR>

" Netrw Setting ---------------------------------------------------------------
map <leader>ex :Vexplore<space>
map ex :Vexplore ./<CR>
let g:netrw_hide = 1
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1
let g:netrw_chgwin = 2
let g:netrw_list_hide = '.*\.swp$'
let g:netrw_localrmdir = 'rm -rf'
let g:netrw_sort_by = 'time'
let g:netrw_sort_direction = 'reverse'

" Marks Setting ---------------------------------------------------------------
nnoremap <leader>md :Delmarks<space>

" Display ---------------------------------------------------------------------
" when scrolling, keep cursor 2 lines away from screen border
set scrolloff=2
set display+=lastline
set title
"set spell

" Split -----------------------------------------------------------------------
" More natural split opening
set splitbelow
set splitright
nnoremap <leader>s :split<space>
nnoremap <leader>v :vsplit<space>
nnoremap <leader>S :split<CR>
nnoremap <leader>V :vsplit<CR>

" Better backup, swap and undos storage ---------------------------------------
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, 'p')
endif
if !isdirectory(&directory)
    call mkdir(&directory, 'p')
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
endif

" NO system bell --------------------------------------------------------------
set visualbell    " ┐
set noerrorbells  " │ Disable beeping and window flashing
set t_vb=         " ┘ https://vim.wikia.com/wiki/Disable_beeping

" Function - Autoremove white space in end of line ----------------------------
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
autocmd BufWritePre * call RemoveTrailingWhitespace()

" Function - Line length warnings [Not working now] ----------------------------
"function! RemoveWidthLimitWarnigns()
    "silent! call matchdelete(4)
"endfunction
"function! InsertWidthLimitWarnings()
    "call RemoveWidthLimitWarnigns()
    "call matchadd('ErrorMsg', '\\%>79v.\\+', 10, 4)
"endfunction
"nnoremap <leader>bo :call InsertWidthLimitWarnings()<CR>:echo '80 char-bound ON'<CR>
"nnoremap <leader>bf :call RemoveWidthLimitWarnigns()<CR>:echo '80 char-bound OFF'<CR>

" Function - Line length warnings [Working instead] ----------------------------
highlight OverLength ctermbg=red ctermfg=white guibg=#ff0000 guifg=#ffffff
highlight UnlimitLength ctermbg=NONE guibg=NONE
nnoremap <leader>bo :match OverLength /\%81v.\+/<CR>:echo '80 char-bound ON'<CR>
nnoremap <leader>bf :match UnlimitLength /\%81v.\+/<CR>:echo '80 char-bound OFF'<CR>

" Function - Word replacement --------------------------------------------------
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
noremap <leader>rr :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
noremap <leader>rw :call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
noremap <leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
noremap <leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
noremap <leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>

" Function - Foldcolumn display ------------------------------------------------
noremap <F7> :set foldcolumn=6<CR>:echo 'Foldcolumn ON'<CR>
noremap <leader><F7> :set foldcolumn=0<CR>:echo 'Foldcolumn OFF'<CR>
inoremap <F7> :set foldcolumn=6<CR>:echo 'Foldcolumn ON'<CR>
inoremap <leader><F7> :set foldcolumn=0<CR>:echo 'Foldcolumn OFF'<CR>

" Function - Overwrite
command! Sudow execute 'w !sudo tee % > /dev/null'

" Unicode display --------------------------------------------------------------
if has('multi_byte')
    if &termencoding == ''
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

" Run python script in vim -----------------------------------------------------
" # Test python version that want (In python)
" import sys
" print(sys.version_info)
autocmd FileType python map <buffer> <leader><F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <leader><F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" =============================================================================
" Vim-plug initialization (Get vim-plug by curl)
" =============================================================================
" Avoid modify this section, unless you are very sure of what you are doing
" Note: curl must already be installed
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo 'Installing Vim-plug...'
    echo ''
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" Manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" =============================================================================
" Vim Active plugins
" =============================================================================
" You can disable or add new ones here:
" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.vim/plugged')

" Plugins from github repos:
" *****************************************************************************

" [Vim theme] -----------------------------------------------------------------
Plug 'morhetz/gruvbox'
Plug 'gkjgh/cobalt'
Plug 'NLKNguyen/papercolor-theme'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" [Must-have] -----------------------------------------------------------------
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/IndexedSearch'
Plug 'vim-scripts/LargeFile'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" [Not Must-have but Useful] --------------------------------------------------
Plug 'vim-scripts/AutoComplPop'
Plug 'junegunn/fzf' ", { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-utils/vim-man'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'szw/vim-maximizer'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" [Python coding] -------------------------------------------------------------
Plug 'dense-analysis/ale'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'

" [Optional] ------------------------------------------------------------------
Plug 'ryanoasis/vim-devicons'
Plug 'shime/vim-livedown'
"Plug 'tmux-plugins/vim-tmux-focus-events'
"Plug 'roxma/vim-tmux-clipboard'
"Plug 'davidhalter/jedi-vim'
"Plug 'junegunn/goyo.vim'
"
" [Not used anymore, just backup] ---------------------------------------------
"Plug 'scrooloose/syntastic'
"Plug 'dyng/ctrlsf.vim'
"Plug 'jremmen/vim-ripgrep'
"Plug 'kien/tabman.vim'
"Plug 'dbeniamine/cheat.sh-vim'
"Plug 'junegunn/limelight.vim'
"Plug 'ycm-core/YouCompleteMe'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" =============================================================================
" Install plugins the first time vim runs
" =============================================================================
if vim_plug_just_installed
    echo "Installing bundles, please ignore key map error messages"
    :PlugInstall
endif

" =============================================================================
" Plugins settings and mappings
" =============================================================================
" Edit them as you wish.

" Backup of old vim-powerline installation
" Powerline-status ------------------------------------------------------------
" " (1) sudo intall vim-powerline (Fedora)
" " (2) sudo apt-get install powerline (Ubuntu)
" " (3) activate manually
" "   - python3 from powerline.vim import setup as powerline_setup
" "   - python3 powerline_setup()
" "   - python3 del powerline_setup

" For special character support
" NERDFont Installation -------------------------------------------------------
" mkdir -p ~/.local/share/fonts
"cd ~/.local/share/fonts && curl -fLo \
"Droid Sans Mono for Powerline Nerd Font Complete.otf" \
"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

" Vim Airline -----------------------------------------------------------------
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Vim Airline Colortheme ------------------------------------------------------
"let g:airline_theme = 'base16_gruvbox_dark_hard'
let g:airline_theme = 'powerlineish'
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
map <silent><leader>af :AirlineRefresh<CR>:echo 'Airline Refreshed'<CR>
set showcmd " This line must be added after airline plugin"

" Tagbar ----------------------------------------------------------------------
" autofocus on tagbar open
let g:tagbar_autofocus = 1
let g:tagbar_map_showproto = 'd'
" toggle tagbar display
map <silent><F4> :TagbarToggle<CR>
map <silent><leader><F4> :TagbarToggle<CR>

" NERDTree --------------------------------------------------------------------
" auto turn on NERDTree
" autocmd vimenter * NERDTree
" toggle nerdtree display
map <silent><leader><F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
map <silent>,t :NERDTreeFind<CR>
map <leader>pwd :pwd<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let g:NERDTreeMouseMode = 3
let g:NERDTreeDirArrows = ''
" auto show NERDTree if there's no file
autocmd vimenter * if !argc() | NERDTree | endif

" Rainbow parentheses ---------------------------------------------------------
" don;t enable when start up
let g:rainbow_active = 0
nnoremap <leader>rb :RainbowToggle<CR>:echo 'Toggle Rainbow'<CR>

" Commentary ------------------------------------------------------------------
autocmd FileType python,shell set commentstring=#\ %s
autocmd FileType mako set cms=##\ %s

" Ale (Syntax check) ----------------------------------------------------------
let g:ale_enabled = 0
nnoremap <leader>ss :ALEToggle<CR>

" Python Syntax ---------------------------------------------------------------
let g:python_highlight_all = 1

" Fortran ---------------------------------------------------------------------
" Ensure correct highlighting for
" Fortran free-form source code
" and turn syntax highlighting on
let fortran_free_source = 1
let fortran_do_enddo = 1

" LargeFile -------------------------------------------------------------------
" File unit: MB
let g:LargeFile = 10

" Indent Guides ---------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
nnoremap <leader>ig :IndentGuidesToggle<CR>:echo 'Toggle Indent Guides'<CR>

" Indent Line -----------------------------------------------------------------
let g:indentLine_enabled = 0
let g:indentLine_char = '¦'

" Auto-pairs ------------------------------------------------------------------
let g:AutoPairsShortcutToggle = '<leader>ap'

" fzf.vim ---------------------------------------------------------------------
" Caution:
"   - ripgrep must be installed if Rg function is needed
" In fzf:
"   - <Ctrl + T> : Open in new tab
"   - <Ctrl + X> : Open in new horizontal split
"   - <Ctrl + V> : Open in new vertical split
nnoremap <leader>bs :Buffers<CR>
nnoremap <leader>fs :Files<space>
nnoremap <leader>lc :Locate<space>
nnoremap <leader>rg :Rg<space>
nnoremap <leader>ll :Lines<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>tg :Tags<CR>
nnoremap <leader>bg :BTags<CR>
nnoremap <leader>hh :History<R>
nnoremap <leader>ma :Marks<CR>
nnoremap <leader>dd :Windows<CR>
nnoremap <leader>ft :Filetypes<CR>
nnoremap <leader>cd :Commands<CR>
nnoremap <leader>nm :Maps<CR>
nnoremap <leader>ht :Helptags<CR>

" Easymotion ------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" Keep cursor column
let g:EasyMotion_startofline = 0
" JK motions: Line motions
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>h <Plug>(easymotion-linebackward)
nmap <leader><leader>f <Plug>(easymotion-overwin-f)
nmap <leader>1 <Plug>(easymotion-overwin-f2)
nmap <leader>2 <Plug>(easymotion-overwin-fn)

" Incsearch Easymotion --------------------------------------------------------
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" Multiple Cursors ------------------------------------------------------------
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<C-l>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Vim maximizer ---------------------------------------------------------------
nnoremap <silent><leader>z :MaximizerToggle<CR>
vnoremap <silent><leader>z :MaximizerToggle<CR>gv
inoremap <silent><leader>z <C-o>:MaximizerToggle<CR>

" Vim cheat -------------------------------------------------------------------
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_shell_checkers = ['shellcheck']

" AutoComplPop ----------------------------------------------------------------
set complete+=kspell
set completeopt=noinsert,noselect,menuone
" previous/next suggestion
inoremap `` <C-p>
inoremap `1 <C-n>
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><C-k> pumvisible() ? "\<c-p>" : "\<C-k>"
inoremap <expr><C-j> pumvisible() ? "\<c-n>" : "\<C-j>"
inoremap <expr><C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr><C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
" enable/disable autopop
map <leader>` :AcpDisable<CR>
map <leader>~ :AcpEnable<CR>

" Vim GitGutter ---------------------------------------------------------------
set updatetime=100
map <leader>gt :GitGutterToggle<CR>

" Livedown --------------------------------------------------------------------
" https://github.com/shime/vim-livedown
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the browser to use, can also be firefox, chrome or other,
" depending on your executable
let g:livedown_browser = "brave-browser"
" Vim Colorscheme - Gruvbox ---------------------------------------------------
let g:gruvbox_contrast_dark='soft'

" Vim Colorscheme - Monokai-tasty ---------------------------------------------
let g:vim_monokai_tasty_italic = 1

" Vim Colorscheme - Papercolor ------------------------------------------------
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

" Colorscheme -----------------------------------------------------------------
colorscheme vim-monokai-tasty
"colorscheme gruvbox
"colorscheme cobalt
"colorscheme PaperColor

" Common Background Setting (Transparent Background) --------------------------
" hi command must be entered after colorscheme
set t_Co=256
set bg=dark
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE gui=bold guifg=#808080 guibg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE gui=bold guifg=#00ff00 guibg=NONE
hi Normal guibg=NONE ctermbg=NONE

" =============================================================================
" End of Vim configuration, automatically reload current config after saving
" =============================================================================
" Automated run vim configuration file just after saving -----------------------
autocmd BufWritePost $MYVIMRC source $MYVIMRC
