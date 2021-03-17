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
if has("termguicolors")
    set termguicolors
endif

" 256 term color support
if !has('gui_running')
    set t_Co=256
endif

" Set leaderkey ---------------------------------------------------------------
let mapleader = ' '

" Map insert mode Esc key -----------------------------------------------------
" - Use Ctrl+v to escape
inoremap ii <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>

" Beginning/End, PageUp/PageDown ----------------------------------------------
map <leader>b 0
map <leader>s 0
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

" Shell command ---------------------------------------------------------------
map <C-c> :!
imap <C-c> :!
map <leader>m :Man<space>

" VIM built-in setting --------------------------------------------------------
filetype on
" Automatically executed by VIM-plug
"filetype plugin on
"filetype indent on
"syntax enable

" VIM window control ----------------------------------------------------------
" [Also integrate with tmux now, check vim-tmux-navigator]
nnoremap <silent><leader>; <C-W><C-W>
nnoremap <silent><leader>h <C-W>h
nnoremap <silent><leader>j <C-W>j
nnoremap <silent><leader>k <C-W>k
nnoremap <silent><leader>l <C-W>l
nnoremap <silent><leader><Left>  <C-W>h
nnoremap <silent><leader><Down>  <C-W>j
nnoremap <silent><leader><Up>    <C-W>k
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
set wrap
set confirm
set incsearch
set ignorecase
set nocompatible
set nostartofline
set modifiable
set wildmenu "show memu options
set clipboard=unnamedplus "shared system clipboard, gvim must be installed"

" Comment  highlight ----------------------------------------------------------
noremap <F8> :hi Comment ctermfg=14 guifg=#00ffff<CR>:echo 'Hi-Comment ON'<CR>
noremap <leader><F8> :hi Comment ctermfg=245 guifg=#8a8a8a<CR>:echo 'Hi-Comment OFF'<CR>

" Wild menu settings ----------------------------------------------------------
set wildmode=list:full

" Search settings -------------------------------------------------------------
set ruler
set cursorline
set cursorcolumn
set hlsearch
map <leader>/ :set hlsearch!<CR>:echo 'Toggle Highlight'<CR>
map <leader>? :set hlsearch!<CR>:echo 'Toggle Highlight'<CR>

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
nnoremap <leader>sv :mkview<CR>:echo 'Setting Saved ...'<CR>
nnoremap <leader>ld :loadview<CR>:echo 'Setting Loaded ...'<CR>
nnoremap <leader>ff za<CR>:echo 'Toggle Current Fold...'<CR>
nnoremap <leader>cf zM<CR>:echo 'Close All Folds ...'<CR>
nnoremap <leader>of zR<CR>:echo 'Open All Folds ...'<CR>

" Tab Setting -----------------------------------------------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"autocmd FileType python setlocal et ts=4 sw=4 sts=4
map <leader>ts :tabs<CR>
map <leader>tt :tabnew<space>
map <leader>td :tabclose<space>
map <leader>tdd :tabclose<CR>:echo 'CLOSE CURRENT TAB'<CR>
map <tab>p :tabprevious<CR>:echo 'PREVIOUS TAB'<CR>
map <tab>n :tabnext<CR>:echo 'NEXT TAB'<CR>
map <silent><C-Left> :tabprevious<CR>
map <silent><C-Right> :tabnext<CR>
map <silent><A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
map <silent><A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
map <silent><leader><F1> <Esc>:tabprevious<CR>:echo 'PREVIOUS TAB'<CR>
map <silent><F1> <Esc>:tabnext<CR>:echo 'NEXT TAB'<CR>

" Buffer Setting --------------------------------------------------------------
set hidden
map <leader>ls :ls<CR>
map <leader>bb :edit<space>
"map <leader>bf :buffer<space>
map <leader>bs :buffers<CR>
map <leader>ba :badd<space>
map <leader>bd :bdelete<space>
map <silent><leader>bdd :bdelete<CR>:echo 'DELETE CURRENT BUFFER'<CR>
map <silent><leader><F2> <Esc>:bp<CR>:echo 'PREVIOUS BUFFER'<CR>
map <silent><F2> <Esc>:bn<CR>:echo 'NEXT BUFFER'<CR>

" Marks Setting ---------------------------------------------------------------
nnoremap <leader>md :Delmarks<space>

" Display ---------------------------------------------------------------------
" when scrolling, keep cursor 2 lines away from screen border
set scrolloff=3
set display+=lastline
set title

" Split -----------------------------------------------------------------------
" More natural split opening
set splitbelow
set splitright
" remove ugly vertical lines on window division
set fillchars+=vert:\
nnoremap <leader>z :split<space>
nnoremap <leader>v :vsplit<space>
nnoremap <leader>Z :split<CR>
nnoremap <leader>V :vsplit<CR>

" Window Chooser --------------------------------------------------------------
nmap  <leader><Enter> <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Better backup, swap and undos storage ---------------------------------------
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after re-opening
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
set encoding=utf-8

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
" Color themes
Plug 'patstockwell/vim-monokai-tasty'
" Airline (status line)
"Plug 'vim-airline/vim-airline'
" Airline themes
"Plug 'vim-airline/vim-airline-themes'
" Powerline symbols
"Plug 'ryanoasis/vim-devicons'
" Lightline
Plug 'itchyny/lightline.vim'

" [File/Code Browsing] --------------------------------------------------------
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" File browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Class/module browser
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" System Man usage
Plug 'vim-utils/vim-man'

" [Vim extra functions] -------------------------------------------------------
" Vim settings for opening large files
Plug 'vim-scripts/LargeFile'
" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'
" History of yank
Plug 'vim-scripts/YankRing.vim'
" Generate bracket/quotation in pair
Plug 'jiangmiao/auto-pairs'
" Functions related to quotation
Plug 'tpope/vim-surround'
" Vim window maximizer
Plug 'szw/vim-maximizer'
" Window chooser
Plug 't9md/vim-choosewin'
" Easymotion (Key-mapping moving in vim)
Plug 'easymotion/vim-easymotion'
" Easymotion + incsearch [Not used anymore]
"Plug 'haya14busa/incsearch-easymotion.vim'
"" Auto popup completion options from vim [Must be disable if deoplete is used]
"Plug 'vim-scripts/AutoComplPop' [Not used anymore]
" Fancy startup page of vim [Not used anymore]
"Plug 'mhinz/vim-startify'

" [Functions for coding] ------------------------------------------------------
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Paint paired bracket/quotation in different color
Plug 'luochen1990/rainbow'
" Save last . motion for next time usage
Plug 'tpope/vim-repeat'
" Multiple language syntax support
Plug 'dense-analysis/ale', { 'for': ['python', 'fortran', 'html'] }
" Languge packs
Plug 'sheerun/vim-polyglot'
" Indent guide
Plug 'nathanaelkane/vim-indent-guides', { 'for': 'python' }
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Multiple cursor with incsearch support [Not used anymore]
"Plug 'terryma/vim-multiple-cursors'

" [Git] -----------------------------------------------------------------------
" Git integration
Plug 'tpope/vim-fugitive'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" [Python coding] -------------------------------------------------------------
" More python syntax highlight
Plug 'vim-python/python-syntax', { 'for': 'python' }
" Python autocompletion
Plug 'Shougo/deoplete.nvim', { 'for': 'python' }
Plug 'roxma/nvim-yarp', { 'for': 'python' }
" Help communicate beteen vim and neovim [needed for deoplete.nvim]
Plug 'roxma/vim-hug-neovim-rpc', { 'for': 'python' }
" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'Shougo/context_filetype.vim', { 'for': 'python' }
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" Sort python import [too much time-consuming]
"Plug 'fisadev/vim-isort'

" [Fortran coding] ------------------------------------------------------------
" Fortran syntax support
Plug 'tomedunn/vim.fortran', { 'for': 'fortran' }

" [Tmux] ----------------------------------------------------------------------
" Share clipboard between vim and tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
" Navigate seamlessly in vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" [HTML coding] ---------------------------------------------------------------
" Highlight matching html tags
Plug 'valloric/MatchTagAlways', { 'for': 'html' }
" Generate html in a simple way
Plug 'mattn/emmet-vim', { 'for': 'html' }
" Generate closetag for HTML
Plug 'alvan/vim-closetag', { 'for': 'html' }

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" Check vim startup time
" vim --startuptime timeCost.txt timeCost.txt

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

" Backup of old vim-powerline installation [Not used anymore, use airline now]
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
"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/\
"DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf

" Vim Airline colortheme ------------------------------------------------------
"let fancy_symbols_enabled = 1

"if fancy_symbols_enabled
    " Option 1: Fancy fonts
    "let g:airline_theme = 'bubblegum'
    "let g:airline_powerline_fonts = 1
    "let g:airline#extensions#tabline#enabled = 1
    """ custom airline symbols
    "if !exists('g:airline_symbols')
       "let g:airline_symbols = {}
    "endif
    "let g:airline_left_sep = ''
    "let g:airline_left_alt_sep = ''
    "let g:airline_right_sep = ''
    "let g:airline_right_alt_sep = ''
    "let g:airline_symbols.branch = '⭠'
    "let g:airline_symbols.readonly = '⭤'
    "let g:airline_symbols.linenr = '⭡'
"else
    " Option 2: Blend fonts
    "let g:airline_powerline_fonts = 0
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '|'
    "let g:webdevicons_enable = 0
"endif

" Vim Airline -----------------------------------------------------------------
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#formatter = 'default'
"map <silent><leader>af :AirlineRefresh<CR>:echo 'Airline Refreshed ...'<CR>

" Lightline -------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Status line -----------------------------------------------------------------
set noshowmode "no vim-built-in mode statusline
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set showcmd " This line must be added after airline plugin"

" Tagbar ----------------------------------------------------------------------
" autofocus on tagbar open
let g:tagbar_autofocus = 1
let g:tagbar_map_showproto = 'd'
" toggle tagbar display
map <silent><F4> :TagbarToggle<CR>
map <silent><leader><F4> :TagbarToggle<CR>

" NERDTree --------------------------------------------------------------------
" toggle nerdtree display
map <silent><leader><F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
map <silent>,t :NERDTreeFind<CR>
map <leader>pwd :pwd<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let g:NERDTreeMouseMode = 3
let g:NERDTreeDirArrows = ''

" Tasklist --------------------------------------------------------------------
map <leader>tl :TaskList<CR>

" Rainbow parentheses ---------------------------------------------------------
" don;t enable when start up
let g:rainbow_active = 0
nnoremap <leader>rb :RainbowToggle<CR>:echo 'Toggle Rainbow'<CR>

" Commentary ------------------------------------------------------------------
"autocmd FileType python,shell set commentstring=#\ %s
"autocmd FileType mako set cms=##\ %s

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

" YankRing --------------------------------------------------------------------
let g:yankring_history_dir = '~/.vim/dirs/'
nmap <leader>ys :YRShow<CR>

" Auto-pairs ------------------------------------------------------------------
let g:AutoPairsShortcutToggle = '<leader>ap'

" fzf.vim ---------------------------------------------------------------------
" Caution:
"   - ripgrep must be installed if Rg function is needed
" In fzf:
"   - <Ctrl + T> : Open in new tab
"   - <Ctrl + X> : Open in new horizontal split
"   - <Ctrl + V> : Open in new vertical split
nnoremap <leader>bf :Buffers<CR>
nnoremap <leader>fs :Files<space>
nnoremap <leader>lc :Locate<space>
nnoremap <leader>rg :Rg<space>
nnoremap <leader>ln :Lines<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>tg :Tags<CR>
nnoremap <leader>bg :BTags<CR>
nnoremap <leader>hs :History<CR>
nnoremap <leader>mk :Marks<CR>
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
map <leader>jj <Plug>(easymotion-j)
map <leader>kk <Plug>(easymotion-k)
map <leader>ll <Plug>(easymotion-lineforward)
map <leader>hh <Plug>(easymotion-linebackward)
map <leader>11 <Plug>(easymotion-overwin-f)
map <leader>22 <Plug>(easymotion-overwin-f2)
"map <leader>nn <Plug>(easymotion-overwin-fn)
map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)
map <leader><leader>l <Plug>(easymotion-lineforward)
map <leader><leader>h <Plug>(easymotion-linebackward)
map <leader><leader>1 <Plug>(easymotion-overwin-f)
map <leader><leader>2 <Plug>(easymotion-overwin-f2)

" Incsearch Easymotion --------------------------------------------------------
"map z/ <Plug>(incsearch-easymotion-/)
"map z? <Plug>(incsearch-easymotion-?)
"map zg/ <Plug>(incsearch-easymotion-stay)

" Multiple Cursors ------------------------------------------------------------
"let g:multi_cursor_use_default_mapping = 0
"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_select_all_word_key = '<C-l>'
"let g:multi_cursor_next_key            = '<C-n>'
"let g:multi_cursor_prev_key            = '<C-p>'
"let g:multi_cursor_skip_key            = '<C-x>'
"let g:multi_cursor_quit_key            = '<Esc>'

" Vim maximizer ---------------------------------------------------------------
nnoremap <silent><leader>x :MaximizerToggle<CR>
vnoremap <silent><leader>x :MaximizerToggle<CR>gv
inoremap <silent><leader>x <C-o>:MaximizerToggle<CR>

" Signify ------------------------------
" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" AutoComplPop ----------------------------------------------------------------
" Disabled if Deoplete is enabled
"set complete+=kspell
"set completeopt+=noselect
" enable/disable autopop
"map <leader>` :AcpDisable<CR>
"map <leader>~ :AcpEnable<CR>

" Deoplete --------------------------------------------------------------------
" pynvim is needed [Installation: pip3 install --user pynvim]
" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview
" Use deoplete.
let g:deoplete#enable_at_startup = 1
autocmd FileType python call deoplete#custom#option({
\   'ignore_case': v:true,
\   'smart_case': v:true,
\})
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Popup window selection ------------------------------------------------------
" previous/next suggestion
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><C-k> pumvisible() ? "\<c-p>" : "\<C-k>"
inoremap <expr><C-j> pumvisible() ? "\<c-n>" : "\<C-j>"
inoremap <expr><C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr><C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" Jedi-vim --------------------------------------------------------------------
"" Disable autocompletion (using deoplete instead)
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

" Colorscheme -----------------------------------------------------------------
colorscheme vim-monokai-tasty

" Common Background Setting (Transparent Background) --------------------------
" hi command must be entered after colorscheme
set bg=dark
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE gui=bold guifg=#808080 guibg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE gui=bold guifg=#00ff00 guibg=NONE
hi Normal guibg=NONE ctermbg=NONE

" Function - Line length warnings [Must be added at last ]---------------------
highlight OverLength ctermbg=red ctermfg=white guibg=#ff0000 guifg=#ffffff
highlight UnlimitLength ctermbg=NONE guibg=NONE
nnoremap <leader>wo :match OverLength /\%81v.\+/<CR>:echo '80 char-bound ON'<CR>
nnoremap <leader>wf :match UnlimitLength /\%81v.\+/<CR>:echo '80 char-bound OFF'<CR>

" =============================================================================
" End of Vim configuration, automatically reload current config after saving
" =============================================================================
" Automated run vim configuration file just after saving -----------------------
"autocmd BufWritePost $MYVIMRC source $MYVIMRC
