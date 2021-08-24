" .vimrc
" ============================================================================
" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" Modified [Vim]/[Neovim] version:[8.2]/[v0.4.4]
" by Kuan-Hsien Wu, Sheng-Jun Lin
" ============================================================================
" This vim configuration is for both vim and neovim

" Note:
" Vim / Neovim configuration file --------------------------------------------
" -- Vim configuration file
"    -- Store in ~/.vimrc
" -- Neovim configuration file
"    -- Store in ~/.config/nvim/init.vim

" ============================================================================
" Vim and Neovim configuration notes
" ============================================================================
" Followings are problems, recommended solutions, and plugin-function support
" notes for configuration

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
"       -- Install formatter with terminal:
"           -- (1) pip install isort
"           -- (2) pip install pyment
"           -- (3) pip install yapf
"       -- Use formatter in vim command line:
"           -- Usage :Neoformat! [lanaguage] [formatter]
"           --  e.g. :Neoformat!   python       yapf
"       -- Recommended PYTHON usage set (in order):
"           -- (1) :Neoformat isort   # Sort import module
"           -- (2) :Neoformat pyment  # Add description of function/class
"           -- (3) :Neoformat yasf    # Format to PEP8 standard

" Note:
" Python-completion and tmux-yank-clipboard on ZEUS --------------------------
" -- Use neovim and everything is fine, but notice that neovim support of
"    Fedora repo is for Fedora 25 and higher version. For now, Seb used
"    AppImage directly from neovim website
" -- Python-completion dependence
"    -- jedi-Vim: pip install jedi
"    -- deoplete: pip install pynvim
"    -- ipdb    : pip install ipdb
"    -- ipython : pip install ipython (version >= 7.2)
" -- Python packages already installed in somewhere else
"    -- Use: pip install (--user) --ignore_installed <PACKAGE_NAME>

" Note:
" Keyboard key repeat time settings ------------------------------------------
" -- Speed up/down key repeat time for pressing key
"    -- e.g jjjjjjjj, kkkkkkkkkk, wwwwwwwwwww
" -- Use Xset to set key repeat
"    --      xset [repeat rate] [start repeat time (ms)]  [repeat rate (/sec)]
"    -- e.g. xset     r rate              300                     40

" ============================================================================
" Vim and Neovim settings (***MUST-READ SESSION***)
" ============================================================================
" Select vim-plug to load, set guicolor (real color) support, and etc.

" Enable/Disable Vim-plug ----------------------------------------------------
" Assign 1/0 to enable/disable plug option

" Use vim or neovim (Auto-detect)
let using_neovim = has('nvim')
let using_vim = !using_neovim
" Check if vim version >= 8.0 (also for neovim >= 0.5)
let using_vim8 = 1
" Customize vim theme (Include colortheme and statusline)
let using_customized_theme = 1
" Fancy symbols (Mainly affect lightline and nerdtree icon)
let using_fancy_symbols = 1
" Wal theme support (Xresources colortheme support, check pywal)
"let using_wal_theme = isdirectory('/home/jordankhwu/.cache/wal')
let using_wal_theme = 0
" Extra vim-plug (Include easymotion, yankring, autocolpop, and etc.)
let using_extra_plug = 1
" Coding tools vim-plug (Include syntax support, git function, and etc.)
let using_coding_tool_plug = 1
" Python Completion (Use deoplete and jedi, neovim is recommended to be used)
let using_python_completion = 1
" Python that used to install jedi, pynvim and python packages for completion
" Search python environment you are using [very time-consuming]
"let python_for_completion = system('which python')
let python_for_completion = '/home/jordankhwu/anaconda3/bin/python'
" Support of external gui software (e.g. Okular, Google-chrome, and etc.)
let using_gui_software = 1

" TERM GUI color -------------------------------------------------------------
" Ctermcolors only support max 256 color
" Termguicolors can support html color code

" Wal colortheme does not work well with termguicolors
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

" Vim built-in filetype setting ----------------------------------------------
" Following settings are later automatically executed by VIM-plug
" -- filetype plugin on
" -- filetype indent on
" -- syntax enable
filetype off

" Set leaderkey --------------------------------------------------------------
" Default leadkey '\'
let mapleader = ' '

" Map insert mode key --------------------------------------------------------
" Note:
" -- Ctrl+r+(register) (Paste register)
" -- Ctrl+[n/p] (Autocompletion next/prev candidate)
" -- Ctrl+[d/t] (Unindent/Indent current line)

" Map exit insert mode (Esc/Ctrl+[) to ii, kj
" -- Use Ctrl+v to escape for 'ii' word (e.g. ascii)
imap ii <Esc>
imap kj <Esc>
" Add break point for text-writing undo
" e.g. w/o bp: test,test,test --undo->
" e.g. w/i bp: test,test,test --undo-> test,test,
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u

" Map normal/visual/opterator-pending mode key -------------------------------
" Note:
" -- z+[t/z/b/h/l]: Scroll window top/center/bottom/left/right
" -- Ctrl+[i/o]: Jump to Next/Prev cursor location, works even between files
" -- :jumps: show all jump history
" -- g+[;/,]: Goto Older/Newer change
" -- :changes: Show all change history
" -- g+[j/k/l/h]: Move in visual lines instead of real lines in WRAP text
" -- g+[uu/UU/~~]: Set lowercase/uppercase/toggle for whole line
" -- :g/PATTERN/ACTION: In entire file, for matching PATTERN, do ACTION
" -- g+[t/T]: Goto Next/Prev tab

" Umap ex mode [old school mode] to prevent typo
noremap gQ <nop>
" Umap command history to prevent typo
" Use :<C-f> to open command history instead
noremap q: <nop>
noremap Q <nop>
" Make Y yank to the end of line instead of whole line just like D do
nnoremap Y y$
" Move selection block up/down in visual mode
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
" Tab is already mapped to <C-i> by vim
noremap <S-Tab> <C-o>
" Show jump list and change list
noremap <leader>go :jumps<CR>
noremap <leader>gi :jumps<CR>
noremap <leader>g; :changes<CR>
noremap <leader>g, :changes<CR>

" Save/Load file hotkey ------------------------------------------------------
" Note:
" -- ZZ (Quit and save if there's change in file without comfirmation)
" -- :f <new-filename> (Save current file with new filename)
" -- :earlier Nf (Undo to last N file change)
" -- :later Nf (Redo to N file change)

noremap <leader>qQ :qall<CR>
noremap <leader>qq :q<CR>
noremap <leader>ww :w<CR>
noremap <leader>wq :wq<CR>

" External command -----------------------------------------------------------
" Note:
" -- :r !date (Insert timestamp)
" -- :r !seq [START] [INCREMENT] LAST (Insert number sequence)
" -- :!dir (Show current directory file)
" -- :!del FILENAME (Delete FILENAME)
" -- :!column --table (Columnate selected context in visual mode)
" -- :!sort (Sort selected context in visual mode alphabetically)

" Add number sequence
nnoremap <leader>esq :r !seq<space>
" Add timestamp
nnoremap <leader>ets :r !date<CR>
" Sort selected context alphabetically
vnoremap <leader>est :!sort<CR>

" Vim window/pane/fold configuration -----------------------------------------
" Save current file layout
noremap <F10> :mkview<CR>
" Load current file previous layout
noremap <leader><F10> :loadview<CR>

" Vim split window (pane) control --------------------------------------------
" Split pane navigation [Now integrate with tmux, check vim-tmux-navigator]
" -- <C-w>[h/j/k/l]: Move to L/D/U/R pane
" -- <C-w>[H/J/K/L]: Move pane to L/D/U/R
" Split pane - Split border style
set fillchars+=vert:\ "
" Split pane - More natural split opening
set splitbelow
set splitright
" Split pane action (built-in, extended)
" -- <C-w>T: Move current pane to new tabe
" -- <C-w>n: Add new empty pane
" -- <C-w>[q/c]: Close current pane
" -- <C-w>[s/v]: Open current buffer in split/vsplit
nnoremap <C-w>S :split<space>
nnoremap <C-w>V :vsplit<space>
" Split pane resize (built-in, extended)
" -- <C-w>[+/-]: Increase/Decrease current pane height
" -- <C-w>[>/<]: Increase/Decrease current pane width
" -- <C-w>[_/|]: Maximize current pane horiz/verti
nnoremap <silent><leader>w= :resize +10<CR>
nnoremap <silent><leader>w- :resize -10<CR>
nnoremap <silent><leader>w, :vertical resize +10<CR>
nnoremap <silent><leader>w. :vertical resize -10<CR>

" Vim settings ---------------------------------------------------------------
if using_vim
    set nocompatible      " Not compatible with vi [No need for neovim]
    set ttyfast           " Faster redrawing. [Removed in neovim]
endif
set exrc                  " Search vimrc file in current directory
set timeoutlen=300        " Timeout for entering combined key (milisecond)
set confirm               " Ask for confirmation before leaving vim
set modifiable            " Make current buffer modifable
set encoding=utf-8        " Unicode display support
set clipboard=unnamedplus " Shared system clipboard
set notildeop             " Make ~ a operator like gu, gU, and etc.
set nolazyredraw          " Not only redraw when necessary.

" Line wrap ------------------------------------------------------------------
set nowrap                " Line wrap for small monitor or display window
noremap <leader>wp :set wrap!<CR>

" Spell check ----------------------------------------------------------------
" Note:
" -- ]s: Jump to next misspelled word
" -- [s: Jump to previous misspelled word

set nospell               " Vim built-in spell check
noremap <leader>sp :set spell!<CR>

" Wild menu settings ---------------------------------------------------------
set wildmenu              " Show memu options
set wildmode=list:full    " Show all available input options (or use Ctrl-D)

" Cursor settings ------------------------------------------------------------
set ruler                 " Show cursor position in statusline
set cursorline            " Show vertical line
set nocursorcolumn        " Show horizontal line (laggy sometimes)
" Toggle cursor line/column indicator (horizontal/vertical)
noremap <leader>ch :set cursorline!<CR>
            \:echo 'Toggle Cursor Line [Horizontal]'<CR>
noremap <leader>cv :set cursorcolumn!<CR>
            \:echo 'Toggle Cursor Column [Vertical]'<CR>
" Synchronize cursor between files
" Must be executed in all files that you want to synchronize cursors
noremap <F11> :set cursorbind<CR>:echo 'Synchronized Cursor On'<CR>
noremap <leader><F11> :set nocursorbind<CR>:echo 'Synchronized Cursor Off'<CR>

" Display settings -----------------------------------------------------------
set scrolloff=3           " Keep cursor 3 lines away from bottom
set display+=lastline     " Show line as much as possible
set title                 " Let vim change terminal title

" Search settings ------------------------------------------------------------
" Note:
" -- Ctrl+[t/g]: Goto prev/next matching result before start searching

set incsearch             " Incremental search (character-by-charcter search)
set hlsearch              " Highlight search result
set ignorecase            " Close case sensitive [Needed for smartcase]
set smartcase             " Case sensitive if search contains uppercase letter
noremap <leader>/ :set nohlsearch!<CR>

" Line number settings -------------------------------------------------------
set norelativenumber      " Do not show relative line number
set number                " Show absolute line number
" Toggle absolute/relative line number
noremap <leader><F5> :set number!<CR>
noremap <F5> :set relativenumber!<CR>

" Fold settings --------------------------------------------------------------
" Note:
" -- z+[c/o]: Close/Open current fold
" -- z+[C/O]: Close/Open current fold recursively
" -- z+[m/r]: More/Reduce fold level
" -- z+[M/R/i]: Maximize/Remove/Invert all folds
" -- z+[j/k]: Jump to next/prev fold

" Fold settings
set foldmethod=syntax
set foldcolumn=0
set foldlevel=0
autocmd FileType vim setlocal foldmethod=indent
autocmd FileType python setlocal foldmethod=indent
" Default value (disabled at startup)
set nofoldenable
" Toggle foldcolumn (4 column)
function! FoldColumnToggleShort()
    if &foldcolumn
        setlocal foldcolumn=0
        echo 'foldcolumn=0'
    else
        setlocal foldcolumn=4
        echo 'foldcolumn=4'
    endif
endfunction
" Toggle foldcolumn (8 column)
function! FoldColumnToggleLong()
    if &foldcolumn
        setlocal foldcolumn=0
        echo 'foldcolumn=0'
    else
        setlocal foldcolumn=8
        echo 'foldcolumn=8'
    endif
endfunction
" Toggle foldcolumn (short, long)
nnoremap <silent><F6> :call FoldColumnToggleShort()<CR>
nnoremap <silent><leader><F6> :call FoldColumnToggleLong()<CR>

" Tabe (window) settings -----------------------------------------------------
" Tabe (window) operations
noremap <leader>ts :tabs<CR>
noremap <leader>tt :tabnew<space>
noremap <leader>td :tabclose<space>
noremap <leader>tdd :tabclose<CR>
" Tabe (window) navigation
noremap <silent><F2> :tabnext<CR>
noremap <silent><leader><F2> :tabprevious<CR>
" Tabe (Window) swap
noremap <silent><S-F2>
            \ :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
noremap <silent><leader><S-F2>
            \ :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>

" Buffer settings ------------------------------------------------------------
" Show all buffers
noremap <leader>bs :buffers<CR>
" Add buffer in foreground (use :edit! to give up all changes)
noremap <leader>bb :edit<space>
" Undo buffer to last save
noremap <leader>bu :edit!<CR>
" Add buffer in background
noremap <leader>ba :badd<space>
" Delete buffer
noremap <leader>bd :bdelete<space>
noremap <leader>dd :bdelete<CR>:echo 'DELETE CURRENT BUFFER
            \ [PRESS CTRL+O TO RECOVER]'<CR>
noremap <leader>bdd :bdelete<CR>'DELETE CURRENT BUFFER
            \ [PRESS CTRL+O TO RECOVER]'<CR>
" Navigate through buffers
noremap <silent><leader><F1> :bprev<CR>
noremap <silent><F1> :bnext<CR>

" Marks settings -------------------------------------------------------------
" Note:
" -- Mark should start with ' (single quotation) or ` (grave symbol)
"    -- '' : Last cursor location
"    -- '" : Last cursor location when buffer closed
"    -- '. : Last modification

" Show marks in vim [Also check markbar plugin]
noremap <leader>mk :marks<CR>
noremap <leader>md :delmarks<space>
noremap <leader>mdd :delmarks!<CR>

" Registers settings ---------------------------------------------------------
" Note:
" -- Register should start with " (double quotation)
"    -- ": : Last command
"    -- ". : Last text
"    -- "% : Current filename
"    -- "/ : Last search

" Show registers in vim [Also check peekaboo plugin]
noremap <leader>rg :registers<CR>
" Command that wipe out all registers
command! WipeReg for i in range(34,122) |
            \ silent! call setreg(nr2char(i), []) | endfor

" Abbreviation settings ------------------------------------------------------
" Note:
" -- :abbclear : Clear abbreviation

" Show abbreviate in vim
noremap <leader>ab :abbreviate<CR>

" Better backup, swap and undos storage --------------------------------------
if using_neovim
    " Directory to place swap files
    set directory=~/.config/nvim/dirs/tmp
    " Make backup files
    set backup
    " Where to put backup files
    set backupdir=~/.config/nvim/dirs/backups
    " Persistent undos - undo after re-opening
    set undofile
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
    " Directory to place swap files in
    set directory=~/.vim/dirs/tmp
    " Make backup files
    set backup
    " Where to put backup files
    set backupdir=~/.vim/dirs/backups
    " Persistent undos - undo after re-opening
    set undofile
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

" Function - Hex editor ------------------------------------------------------
" From https://blog.gtwang.org/useful-tools/how-to-use-vim-as-a-hex-editor/
noremap <leader>eho :%! xxd<CR>
            \:echo 'Hex editor on: TF to binary data'<CR>
noremap <leader>ehf :%! xxd -r<CR>
            \:echo 'Hex editor off: TF to original data'<CR>

" Function - Line length colorcolumn warnings --------------------------------
let g:overlength_column_is_open = 0
" Toggle overlength function
function! OverlengthColumnToggle()
    if g:overlength_column_is_open
        set colorcolumn=
        echo '79th character colorcolumn OFF'
        let g:overlength_column_is_open = 0
    else
        set colorcolumn=79
        echo '79th character colorcolumn ON'
        let g:overlength_column_is_open = 1
    endif
endfunction
" Toggle overlength color column
nnoremap <silent><F7> :call OverlengthColumnToggle()<CR>

" Function - Line length warnings --------------------------------------------
" Here adopt default vim-textwidth 78 as maximum line length
" Default value (disabled at startup)
let g:overlength_warning_is_open = 0
" Toggle overlength function
function! OverlengthToggle()
    if g:overlength_warning_is_open
        match UnlimitLength /\%79v.\+/
        echo 'Over 78 character line highlight OFF'
        let g:overlength_warning_is_open = 0
    else
        match OverLength /\%79v.\+/
        echo 'OVer 78 character line highlight ON'
        let g:overlength_warning_is_open = 1
    endif
endfunction
" Toggle overlength
nnoremap <silent><leader><F7> :call OverlengthToggle()<CR>

" Function - Comment highlight -----------------------------------------------
" Default value (disabled at startup)
let g:comment_highlight_is_open = 0
" Toggle comment highlight function
function! CommentHighlightToggle()
    if g:comment_highlight_is_open
        hi Comment cterm=italic ctermfg=8  guifg=#8a8a8a
        echo 'Hi-Comment OFF'
        let g:comment_highlight_is_open = 0
    else
        hi Comment cterm=italic ctermfg=14 guifg=#00ffff
        echo 'Hi-Comment ON'
        let g:comment_highlight_is_open = 1
    endif
endfunction
" Toggle comment highlight
nnoremap <F8> :call CommentHighlightToggle()<CR>
nnoremap <leader><F8> :call CommentHighlightToggle()<CR>

" ============================================================================
" Customized terminal mode (Only support for vim >= 8.0)
" ============================================================================
" Vim support built-in terminal, by default use system $SHELL

" Terminal mode - open terminal in vim buffer --------------------------------
" -- Enter insert mode to use terminal command line
" -- In terminal buffer, <C-\><C-n> back to normal mode

" Set customized terminal mode keymapping
if using_vim8
    " Map key to enter terminal mode
    if using_neovim
        noremap <F12> :split<CR>:resize 10<CR>:terminal<CR>i
    else
        noremap <F12> :terminal<CR>
    endif
    " Map key for resize pane
    nnoremap <leader>r0 :resize 10 <CR>
    " Map key to go back from terminal mode to normal mode
    " Do not use Esc (which conflicts with fzf window) but <C-\><C-n>
    tnoremap <leader><F12> <C-\><C-n>:echo 'Back to Normal Mode'<CR>
    tnoremap ii <C-\><C-n>:echo 'Back to Normal Mode'<CR>
    tnoremap kj <C-\><C-n>:echo 'Back to Normal Mode'<CR>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    " Terminal customization for neovim
    if using_neovim
        " Auto start command when starting terminal mode
        autocmd TermOpen * setlocal
                    \ nocursorcolumn nocursorline nonumber laststatus=0
        " Auto start command when entering terminal mode
        autocmd TermEnter * setlocal
                    \ nocursorcolumn nocursorline nonumber laststatus=0
        " Auto start command when leaving terminal mode
        autocmd TermClose * setlocal
                    \ cursorcolumn cursorline number laststatus=2
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
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                    \ 'https://raw.githubusercontent.com/junegunn/
                    \vim-plug/master/plug.vim'
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ 'https://raw.githubusercontent.com/junegunn/
                    \vim-plug/master/plug.vim'
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
    " Wal (Autocolorcheme based on wallpaper) [Only work with Cterm color]
    Plug 'dylanaraps/wal.vim', { 'on': 'colorscheme wal' }
    " Color theme (Monokai - high contrast)
    Plug 'patstockwell/vim-monokai-tasty',
                \ { 'on': 'colorscheme vim-monokai-tasty' }
    " Color theme (Gruvbox - low contrast)
    Plug 'morhetz/gruvbox', { 'on': 'colorscheme gruvbox' }
    " Color theme (Srcery - low contrast)
    Plug 'srcery-colors/srcery-vim', { 'on': 'colorscheme srcery' }
    " Color theme (Nord - cold color lower contrast)
    Plug 'arcticicestudio/nord-vim', { 'on': 'colorscheme nord' }
    " Color theme (Oceanic - solorized-like theme)
    Plug 'mhartington/oceanic-next', { 'on': 'colorscheme OceanicNext' }
    " Lightline (status line)
    Plug 'itchyny/lightline.vim'
    " Lightline bufferline
    Plug 'mengelbrecht/lightline-bufferline'
endif

" [File/Code Browsing] -------------------------------------------------------
if using_fancy_symbols
    " Nerdtree and other vim-plug powerline symbols support
    Plug 'ryanoasis/vim-devicons'
    " More highlight in nertree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif
" File browser [support netrw (vim built-in file browser) functions]
Plug 'scrooloose/nerdtree'
" Code class/module/tag browser [Update to latest]
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
" Code and files fuzzy finder and previewer (main progroam)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
" Code and files fuzzy finder and previewer (vim plugin)
Plug 'junegunn/fzf.vim'
" Enhanced previewer for fzf (fuzzy finder)
Plug 'chengzeyi/fzf-preview.vim'

" [Vim useful functions] -----------------------------------------------------
" Sudo write/read files in vim
Plug 'lambdalisue/suda.vim', { 'on': 'SudaWrite' }
" System Man usage
Plug 'vim-utils/vim-man', { 'on': 'Man' }
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Generate bracket/quotation in pair
Plug 'tpope/vim-surround'
" Enable . (repeat motion) for commands (e.g. undo, redo, vim-surround)
Plug 'tpope/vim-repeat'
" Vim window maximizer
Plug 'szw/vim-maximizer', { 'on': 'MaximizerToggle' }
" Window pane selector
Plug 't9md/vim-choosewin'
" Autopair for quotations and brackets
Plug 'jiangmiao/auto-pairs'
" Show vim keybindings (for now only leader key)
Plug 'liuchengxu/vim-which-key'

" [Vim extra functions] ------------------------------------------------------
if using_extra_plug
    " Goyo (Distraction-free mode)
    Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
    " Fancy startup page of vim
    Plug 'mhinz/vim-startify'
    " History of yank
    Plug 'vim-scripts/YankRing.vim'
    " Register investigator
    Plug 'junegunn/vim-peekaboo'
    " Mark investigator
    Plug 'Yilin-Yang/vim-markbar'
    " Easymotion (Key-mapping moving in vim)
    Plug 'easymotion/vim-easymotion'
    " Auto popup completion options from vim
    Plug 'vim-scripts/AutoComplPop'
    " Pending tasks list
    Plug 'fisadev/FixedTaskList.vim', { 'on': 'TaskList' }
    " Paint hex colors in color code background color
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
endif

" [Functions for coding] -----------------------------------------------------
if using_coding_tool_plug
    if using_vim8
        " Additional languge packs
        Plug 'sheerun/vim-polyglot'
        " Multiple language syntax and lint support
        Plug 'dense-analysis/ale',
                    \ { 'for': ['python', 'fortran', 'html'] }
    endif
    " Code formatter
    Plug 'sbdchd/neoformat', { 'on': 'Neoformat' }
    " Paint paired bracket/quotation in different color
    Plug 'luochen1990/rainbow', { 'on': 'RainbowToggle' }
    " Indentline (symbol)
    Plug 'yggdroot/indentLine', { 'on': 'IndentLinesToggle'}
    " Indent line guide (color column)
    Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }
    " Indent text object (i for indent as w for word)
    Plug 'michaeljsmith/vim-indent-object'
    "Multiple cursor with incsearch support
    Plug 'terryma/vim-multiple-cursors'
    " Git integration (Git functions in vim command line)
    Plug 'tpope/vim-fugitive'
    " GitGutter (enhanced signify), also with git integration
    Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle' }
endif

" [Tmux] ---------------------------------------------------------------------
" Clipboard sharing [No need if already using xclip for tmux clipboard]
" Share focus between vim and tmux for clilpboard sharing
"Plug 'tmux-plugins/vim-tmux-focus-events'
" Share clipboard between vim and tmux
"Plug 'roxma/vim-tmux-clipboard'
" Navigate seamlessly in vim and tmux (Ctrl+h/j/k/l)
Plug 'christoomey/vim-tmux-navigator'

" [Neovim/Vim] ---------------------------------------------------------------
" Help communicate beteen vim and neovim [needed for deoplete.nvim]
if using_vim
    Plug 'roxma/vim-hug-neovim-rpc', { 'for': 'python' }
endif
" Yet Another Remote Plugin Framework for Neovim [needed for deoplete]
Plug 'roxma/nvim-yarp', { 'for': 'python' }
" Context filetype library
Plug 'Shougo/context_filetype.vim', { 'for': 'python' }

" [Python coding] ------------------------------------------------------------
if using_python_completion
    " Front end of completion (python and etc.)
    if vim_plug_just_installed
        Plug 'Shougo/deoplete.nvim',
                        \ { 'do': ':autocmd VimEnter * UpdateRemotePlugins' }
    endif
    " Front end of completion (python and etc.)
    Plug 'Shougo/deoplete.nvim', { 'for': 'python' }
    " Python autocompletion
    Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
    " Just to add go-to-definition and similar features, autocompeletion from
    " this plugin is disabled
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
endif
" More python syntax highlight
Plug 'vim-python/python-syntax', { 'for': 'python' }

" [Fortran coding] -----------------------------------------------------------
" Fortran syntax support
Plug 'tomedunn/vim.fortran', { 'for': 'fortran' }

" [HTML coding] --------------------------------------------------------------
" Generate html in a simple way
Plug 'mattn/emmet-vim', { 'for': 'html' }
" Generate closetag for HTML
Plug 'alvan/vim-closetag', { 'for': 'html' }

" [Latex] --------------------------------------------------------------------
if using_gui_software
    " Asynchronous Tex file -> Pdf file preview (pdf reader is needed)
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
endif
" Latex compiler link support (complier need to be installed externally)
Plug 'vim-latex/vim-latex', { 'for': 'tex' }

" [Markdown] --------------------------------------------------------------------
if using_gui_software
    if using_vim8
        " Synchronous markdown file previewer
        Plug 'iamcco/markdown-preview.nvim',
                    \ { 'do': { -> mkdp#util#install() },
                    \ 'for': ['markdown', 'vim-plug']}
    endif
endif

" [I3 syntax highlight] ------------------------------------------------------
" I3 configuration syntax highlight
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3'}

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" Check vim startup time and loaded plugins
" vim --startuptime /tmp/startup.log [file_to_test] +q && vim /tmp/startup.log

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
autocmd FileType python
            \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=-1
" Makefile not support expand tabs to spaces
autocmd FileType make setlocal noexpandtab

" ============================================================================
" Part 2 - Vim-theme settings (Plugins settings and mappings)
" ============================================================================
" Vim-theme settings, edit them as you wish.
" As for colorscheme, it at the end of this plug settings section

" Lightline statusline/tabline options ---------------------------------------
" Lightline style setup
function! LightlineStyle(theme, fancy, central_opaque)

    " Part 1 - Lightline setup -----------------------------------------------
    " Initialize g:lightline variable
    let g:lightline = { 'colorscheme': a:theme }
    " Specify g:lightline dictionary objects
    let g:lightline.enable = { 'statusline': 1, 'tabline': 1 }

    " Part 2 - Statusline setup ----------------------------------------------
    " Active statusline
    let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
    " Inactive statusline
    let g:lightline.inactive = {
        \ 'left': [ [ 'filename' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ] ] }
    " Statusline componet function
    let g:lightline.component_function = { 'gitbranch': 'FugitiveHead', }
    " Fancy symbol for statusline separator
    if a:fancy
        let g:lightline.separator = { 'left': "", "right": "" }
        let g:lightline.subseparator = { 'left': '/', 'right': '/' }
    endif

    " Part 3 - Tabline setup (bufferline plugin) -----------------------------
    " Tabline
    let g:lightline.tabline = {
        \ 'left': [ ['buffers'] ],
        \ 'right': [ ['tabs'] ] }
    " Tabline component
    let g:lightline.component_type = { 'buffers': 'tabsel' }
    let g:lightline.component_expand = {
        \ 'buffers': 'lightline#bufferline#buffers' }
    " Tabline (bufferline plugin)
    let g:lightline#bufferline#show_number = 0
    let g:lightline#bufferline#shorten_path = 1
    let g:lightline#bufferline#unnamed = '[No Name]'
    let g:lightline#bufferline#filter_by_tabpage = 1
    " Fancy character for tabline (bufferline)
    if a:fancy
        let g:lightline#bufferline#enable_devicons = 1
        let g:lightline#bufferline#enable_nerdfont = 1
        let g:lightline#bufferline#unicode_symbols = 1
    endif

    " Part 4 - Miscellaneous setup -------------------------------------------
    " Miscellaneous varaibles
    let g:nord_uniform_status_lines = 0
    " Central bar opaque option
    if !a:central_opaque
        let s:palette = g:lightline#colorscheme
                    \#{g:lightline.colorscheme}#palette
        let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
        let s:palette.visual.middle = s:palette.normal.middle
        let s:palette.insert.middle = s:palette.normal.middle
        let s:palette.inactive.middle = s:palette.normal.middle
        let s:palette.tabline.middle = s:palette.normal.middle
        let s:palette.replace.middle = s:palette.normal.middle
    endif
endfunction

" Conditional lightline status/tab line --------------------------------------
if using_customized_theme
    " Toggle lightline, status/tab line
    noremap <leader>sle :call lightline#enable()<CR>:set noshowmode<CR>
                \:set showtabline=2<CR>:set laststatus=2<CR>
                \:echo "LIGHTLINE ENABLED"<CR>
    noremap <leader>sld :call lightline#disable()<CR>:set showmode<CR>
                \:set showtabline=2<CR>:set laststatus=2<CR>
                \:echo "LIGHTLINE DISABLED"<CR>
    " Disable statusline (including lightline)
    noremap <leader>ssd :call lightline#disable()<CR>:set showmode<CR>
                \:set showtabline=0<CR>:set laststatus=0<CR>
                \:echo "STATUSLINE DISABLED"<CR>
endif

" Function - Reload lightline ------------------------------------------------
" - Reload lightline without close editing files
" - From https://github.com/itchyny/lightline.vim/issues/241
function! LightlineReload()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

" Status/Tab line ------------------------------------------------------------
set noshowmode    " No vim-built-in mode statusline
set laststatus=2  " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set cmdheight=1   " Size of command line height
set showcmd       " This line must be added AFTER statusline option

" Keymapping for bufferline --------------------------------------------------
" Goto buffers
nmap <leader>g1 <Plug>lightline#bufferline#go(1)
nmap <leader>g2 <Plug>lightline#bufferline#go(2)
nmap <leader>g3 <Plug>lightline#bufferline#go(3)
nmap <leader>g4 <Plug>lightline#bufferline#go(4)
nmap <leader>g5 <Plug>lightline#bufferline#go(5)
nmap <leader>g6 <Plug>lightline#bufferline#go(6)
nmap <leader>g7 <Plug>lightline#bufferline#go(7)
nmap <leader>g8 <Plug>lightline#bufferline#go(8)
nmap <leader>g9 <Plug>lightline#bufferline#go(9)
" Close buffers
nmap <leader>d1 <Plug>lightline#bufferline#delete(1)
nmap <leader>d2 <Plug>lightline#bufferline#delete(2)
nmap <leader>d3 <Plug>lightline#bufferline#delete(3)
nmap <leader>d4 <Plug>lightline#bufferline#delete(4)
nmap <leader>d5 <Plug>lightline#bufferline#delete(5)
nmap <leader>d6 <Plug>lightline#bufferline#delete(6)
nmap <leader>d7 <Plug>lightline#bufferline#delete(7)
nmap <leader>d8 <Plug>lightline#bufferline#delete(8)
nmap <leader>d9 <Plug>lightline#bufferline#delete(9)

" ============================================================================
" Part 3 - File/Code browsing settings (Plugins settings and mappings)
" ============================================================================
" File/Code browing settings, edit them as you wish.

" fzf.vim --------------------------------------------------------------------
" Note:
" -- ripgrep must be installed if Rg function is needed
" -- the_silver_searcher must be installed if Ag function is needed

" Add prefix FZF to all fzf commands
let g:fzf_command_prefix = 'FZF'
" Default fzf action keymapping
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }
" fzf layout (Floating in the center of window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" Preview window layout
let g:fzf_preview_window = ['up:50%', 'ctrl-/']
" Buffer (Local vim)
nnoremap <leader>fbL :FZFBLines<CR>
nnoremap <leader>fbl :execute ":FZFBLines " . expand('<cword>')<CR>
nnoremap <leader>fbT :FZFBTags<CR>
nnoremap <leader>fbt :execute ":FZFBTag " . expand('<cword>')<CR>
" All files (Global system)
nnoremap <leader>fgL :FZFLines<CR>
nnoremap <leader>fgl :execute ":FZFLines " . expand('<cword>')<CR>
nnoremap <leader>fgT :FZFTags<CR>
nnoremap <leader>fgt :execute ":FZFTag " . expand('<cword>')<CR>
" File/Pattern search
nnoremap <leader>ffs :FZFFiles<CR>
nnoremap <leader>ffS :FZFFiles<space>
nnoremap <leader>flc :FZFLocate<space>
nnoremap <leader>frg :FZFRg<CR>
nnoremap <leader>fag :FZFAg<CR>
" Git command
nnoremap <leader>fgf :FZFGFiles<CR>
nnoremap <leader>fgs :FZFGFiles?<CR>
nnoremap <leader>fgc :FZFBCommits<CR>
nnoremap <leader>fgC :FZFCommits<CR>
" History
nnoremap <leader>fhs :FZFHistory<CR>
nnoremap <leader>fh: :FZFHistory:<CR>
nnoremap <leader>fh/ :FZFHistory/<CR>
" Buffers/Windows/Marks
nnoremap <leader>fbf :FZFBuffers<CR>
nnoremap <leader>fmk :FZFMarks<CR>
nnoremap <leader>fmp :FZFMaps<CR>
nnoremap <leader>fwd :FZFWindows<CR>
" Miscellaneous
nnoremap <leader>fcd :FZFCommands<CR>
nnoremap <leader>fft :FZFFiletypes<CR>
nnoremap <leader>fht :FZFHelptags<CR>

" NERDTree -------------------------------------------------------------------
" Disable vim built-in netrw
let loaded_netrwPlugin = 1
let NERDTreeWinSize = min([40, winwidth(0) / 5])
let NERDTreeShowLineNumbers = 0
let NERDTreeShowHidden = 0
" Disable bookmark label in nerdtree
let NERDTreeMinimalUI = 0
" Don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let g:NERDTreeMouseMode = 3
let g:NERDTreeDirArrows = ''
" Set nerdtree dir arrow symbols
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
" Open nerdtree with the current file selected
noremap <silent><F3> :NERDTreeFind<CR>
" Toggle nerdtree display
noremap <silent><leader><F3> :NERDTreeToggle<CR>

" Tagbar ---------------------------------------------------------------------
" Autofocus on tagbar open
let g:tagbar_autofocus = 1
let g:tagbar_map_showproto = 'd'
let g:tagbar_width = min([40, winwidth(0) / 5])
" Map tagbar shortcut same as vim fold
let g:tagbar_map_closeallfolds = 'zM'
let g:tagbar_map_openallfolds = 'zR'
let g:tagbar_map_closefold = 'zc'
let g:tagbar_map_openfold = 'zo'
" Toggle tagbar display
noremap <silent><leader><F4> :TagbarToggle<CR>

" ============================================================================
" Part 4 - Vim useful functions settings (Plugins settings and mappings)
" ============================================================================
" Vim useful functions settings, edit them as you wish.

" Vim-man --------------------------------------------------------------------
" Note:
" -- K (Vim helppage for current selected word)

" Open offline manual in system
noremap <leader>mm :execute ":Man " . expand('<cword>')<CR>
noremap <leader>mM :Man<space>

" Nerdcommenter --------------------------------------------------------------
" -- Common prefix: <leader>c
" Disable default mappings
let g:NERDCreateDefaultMappings = 0
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Map manually for minimalism
map <leader>c$ <Plug>NERDCommenterToEOL
map <leader>cA <Plug>NERDCommenterAppend
map <leader>ca <Plug>NERDCommenterAltDelims
map <leader>cc <Plug>NERDCommenterComment
map <leader>cu <Plug>NERDCommenterUncomment

" Vim-surround ---------------------------------------------------------------
" Surround current word or sentence with brackets or html tags
" -- Support surrounding: (), {}, [], "", ''
" -- Difference between left/right bracket
"    -- ysaw{ : test -> { test }
"    -- ysaw} : test -> {test}
" -- Grammar in vim-surround (vim-like)
"    -- Prep. a: around
"    -- Noun, w: word, s: sentence, t: tag
"    -- Verb. d: delete, c: change, y:yield
" -- Visual mode
"    -- use S to trigger vim-surround

" Vim-maximizer --------------------------------------------------------------
" Default mapping is <F3> (Disabled now)
let g:maximizer_set_default_mapping = 0
" Keymapping consistent with TMUX window maximization
nnoremap <silent><leader>z :MaximizerToggle<CR>
vnoremap <silent><leader>z :MaximizerToggle<CR>gv
nnoremap <silent><C-w>z :MaximizerToggle<CR>
vnoremap <silent><C-w>z :MaximizerToggle<CR>gv

" Window-chooser (choosewin)--------------------------------------------------
" Show big overlay letters
let g:choosewin_overlay_enable = 1
nmap <leader><Enter> <Plug>(choosewin)

" Auto-pairs -----------------------------------------------------------------
" Insert, visual, normal mode
let g:AutoPairsShortcutToggle = '<M-`>'
let g:AutoPairsShortcutJump = '<M-j>'
" Insert mode only
" Wrap current word with pair e.g. ()test -> (test)
let g:AutoPairsShortcutFastWrap = '<M-w>'

" Vim-whichkey ---------------------------------------------------------------
" Whichkey layout
let g:which_key_floating_opts = { 'row': '200' }
let g:which_key_sort_horizontal = 1
let g:which_key_hspace = 5
" Map space key to normal/visual mode
vnoremap <silent><leader> :<C-u>WhichKeyVisual '<space>'<CR>
nnoremap <silent><leader> :<C-u>WhichKey '<space>'<CR>

" ============================================================================
" Part 5 - Vim extra functions settings (Plugins settings and mappings)
" ============================================================================
" Vim extra functions settings, edit them as you wish.

" Goyo -----------------------------------------------------------------------
noremap <silent><leader>gy :Goyo<CR>

" YankRing -------------------------------------------------------------------
if using_extra_plug
    if using_neovim
        let g:yankring_history_dir = '~/.config/nvim/'
        " Fix for yankring and neovim problem when system has non-text things
        " copied in clipboard
        let g:yankring_clipboard_monitor = 0
    else
        let g:yankring_history_dir = '~/.vim/dirs/'
    endif
    " Yankring window settings
    let g:yankring_window_height = 13
    let g:yankring_window_auto_close = 1
    " Yankring automatically remap built-in command key mapping (disabled)
    " -- e.g. 'X[x]', 'D[d]', 'Y[y]', 'P[p]', '.', '@', and etc.
    " -- Here disable most of default keymappings except yank replacing
    let g:yankring_window_auto_close = 1
    let g:yankring_record_insert = 0
    let g:yankring_paste_using_g = 0
    let g:yankring_n_keys = ' '
    let g:yankring_o_keys = ' '
    let g:yankring_zap_keys = ' '
    let g:yankring_v_key = ' '
    let g:yankring_del_v_key = ' '
    let g:yankring_paste_n_bkey = ' '
    let g:yankring_paste_n_akey = ' '
    let g:yankring_paste_v_key = ' '
    " Enable yankring replace
    let g:yankring_replace_n_pkey = 'yp'
    let g:yankring_replace_n_nkey = 'yn'
    " Yankring history
    noremap <leader>ys :YRShow<CR>
    noremap <leader>yC :YRClear<CR>
endif

" Peekaboo -------------------------------------------------------------------
" Remap '"', '@' (Normal mode) and '<C-r>' (Insert mode) for register viewer
if using_extra_plug
    let g:peekaboo_window = "vert bo 35new"
    let g:peekaboo_prefix = ''
    let g:peekaboo_compat = 1
endif

" Markbar --------------------------------------------------------------------
" Remap ''', '`' (Normal mode) for mark viewer
if using_extra_plug
    " width of a vertical split markbar
    let g:markbar_width = 40
    " Ditto, but more granularly (any may be omitted)
    let g:markbar_num_lines_context = {
        \ 'peekaboo_around_local': 3,
        \ 'peekaboo_around_file': 1,
    \ }
    " Leave peekaboo markbar enabled, but don't set default mappings
    let g:markbar_set_default_peekaboo_mappings = v:false
    " Peekaboo-like markbar (remap vim built-in ' key)
    nmap ` <Plug>OpenMarkbarPeekabooApostrophe
    " Peekaboo-like markbar (remap vim built-in ` key)
    nmap ' <Plug>OpenMarkbarPeekabooBacktick
endif

" Easymotion -----------------------------------------------------------------
if using_extra_plug
    " Move up and down not back to start of line
    set nostartofline
    " Disable default mappings
    let g:EasyMotion_do_mapping = 0
    " Turn on case-insensitive feature
    let g:EasyMotion_smartcase = 1
    " Keep cursor column
    let g:EasyMotion_startofline = 0
    " Motions
    nmap <leader>j <Plug>(easymotion-j)
    nmap <leader>k <Plug>(easymotion-k)
    nmap <leader>l <Plug>(easymotion-lineforward)
    nmap <leader>h <Plug>(easymotion-linebackward)
endif

" AutoComplPop ---------------------------------------------------------------
if using_extra_plug
    " Enable autocomplpop at startup
    let g:acp_enableAtStartup = 1
    " Toggle autocomplpop function
    let g:AutoCompPop_is_open = 1
    function! AutoCompPopToggle()
        if g:AutoCompPop_is_open
            AcpDisable
            echo 'AutoCompletionPop Disabled'
            let g:AutoCompPop_is_open = 0
        else
            AcpEnable
            echo 'AutoCompletionPop Enabled'
            let g:AutoCompPop_is_open = 1
        endif
    endfunction
    " Toggle autocomplpop
    noremap <leader>` :call AutoCompPopToggle()<CR>
    " Disable autocomplpop for python file [use deoplete instead]
    if using_python_completion
        autocmd FileType python let g:acp_enableAtStartup = 0
    endif
endif

" Popup window selection -----------------------------------------------------
" Previous/next suggestion
" [Double quotation matters here, do not change to single quotation]
if using_extra_plug
    inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
    inoremap <expr><tab>   pumvisible() ? "\<C-n>" : "\<tab>"
    inoremap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
    inoremap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
    inoremap <expr><C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
    inoremap <expr><C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
endif

" Tasklist -------------------------------------------------------------------
if using_extra_plug
    noremap <leader>tl :TaskList<CR>
endif

" Hexokinase -----------------------------------------------------------------
" Set highlighter for hexokinase
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
" All possible values for hexokinase pattern
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla,colour_names'

" ============================================================================
" Part 6 - Vim coding tools settings (Plugins settings and mappings)
" ============================================================================
" Vim coding tools settings, edit them as you wish.

" ALE (Asynchronous Lint Engine) ---------------------------------------------
" -- For python, flake8, pylint or other linting engines must be installed
"    -- pip install flake8
"    -- pip install pylint
if using_coding_tool_plug
    let g:ale_enabled = 0
    noremap <leader>al :ALEToggle<CR>
    noremap <leader>ai :ALEInfo<CR>
    nmap <leader>ak <Plug>(ale_previous_wrap)zz
    nmap <leader>aj <Plug>(ale_next_wrap)zz
endif

" Rainbow parentheses --------------------------------------------------------
if using_coding_tool_plug
    " Don;t enable when start up
    let g:rainbow_active = 0
    noremap <leader>rb :RainbowToggle<CR>
endif

" Indentline -----------------------------------------------------------------
if using_coding_tool_plug
    let g:indentLine_showFirstIndentLevel = 1
    let g:indentLine_fileTypeExclude = ['text', 'markdown', 'latex']
    let g:indentLine_bufTypeExclude = ['help', 'terminal']
    noremap <F9> :IndentLinesToggle<CR>
endif

" Indent guides --------------------------------------------------------------
if using_coding_tool_plug
    let g:indent_guides_enable_on_vim_startup = 0
    let g:indent_guides_start_level = 1
    let g:indent_guides_guide_size = 4
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme *
                \ :hi IndentGuidesOdd  guibg='#303030' ctermbg=225
    autocmd VimEnter,Colorscheme *
                \ :hi IndentGuidesEven guibg='#24242d' ctermbg=194
    noremap <leader><F9> :IndentGuidesToggle<CR>
endif

" Indent object --------------------------------------------------------------
" Indent text object (i for indent as w for word)
" Key bindings from https://github.com/michaeljsmith/vim-indent-object
" -- <count>ai	An Indentation level and line above.
" -- <count>ii	Inner Indentation level (no line above).
" -- <count>aI	An Indentation level and lines above/below.
" -- <count>iI	Inner Indentation level (no lines above/below).

" Multiple-cursors -----------------------------------------------------------
if using_coding_tool_plug
    let g:multi_cursor_use_default_mapping = 0
    let g:multi_cursor_start_word_key      = '<M-n>'
    let g:multi_cursor_select_all_word_key = '<M-n>a'
    let g:multi_cursor_next_key            = '<M-n>'
    let g:multi_cursor_prev_key            = '<M-p>'
    let g:multi_cursor_skip_key            = '<M-o>'
    let g:multi_cursor_quit_key            = '<Esc>'
endif

" Vim-fugitive ---------------------------------------------------------------
" -- :G Summary for current git repository
if using_coding_tool_plug
    noremap <leader>gd :Git diff %<CR>
    noremap <leader>gD :Git diff<CR>
    noremap <leader>gs :Git<CR>
    noremap <leader>gl :GcLog<CR>
    noremap <leader>ga :Git add %<CR>
    noremap <leader>gA :Git add --all<CR>
    noremap <leader>gc :Git commit<CR>
    noremap <leader>gC :Git commit -m<space>
    noremap <leader>gB :Git blame<CR>
    noremap <leader>gR :Git reset<space>
    noremap <leader>gph :Git push<CR>
    noremap <leader>gpl :Git pull<CR>
endif

" GitGutter ------------------------------------------------------------------
if using_coding_tool_plug
    "Disable all gitgutter key mappings
    let g:gitgutter_map_keys = 0
    " Enable gitgutter at start
    let g:gitgutter_enabled = 0
    " Enable gitgutter sign highlight at start
    let g:gitgutter_signs = 1
    " Disable gitgutter line highlight at start
    let g:gitgutter_highlight_lines = 0
    " Disable gitgutter line number highlight at start
    let g:gitgutter_highlight_linenrs = 0
    " Show number of hunk when move between hunks
    let g:gitgutter_show_msg_on_hunk_jumping = 1
    " Show gitgutter prewview in split pane
    let g:gitgutter_preview_win_floating = 0
    " Use Esc key to quit preview pane
    let g:gitgutter_close_preview_on_escape = 1
    " Assign color to GitGutter group
    highlight GitGutterAdd    cterm=bold ctermfg=2 ctermbg=NONE gui=bold guifg=#009900 guibg=NONE
    highlight GitGutterChange cterm=bold ctermfg=3 ctermbg=NONE gui=bold guifg=#bbbb00 guibg=NONE
    highlight GitGutterDelete cterm=bold ctermfg=1 ctermbg=NONE gui=bold guifg=#ff2222 guibg=NONE
    " GitGutter toggle
    noremap <leader>gg :GitGutterToggle<CR>
    noremap <leader>gb :GitGutterBufferToggle<CR>
    " GitGutter highlight toggle
    noremap <leader>ghs :GitGutterSignsToggle<CR>
    noremap <leader>ghl :GitGutterLineHighlightsToggle<CR>
    noremap <leader>ghn :GitGutterLineNrHighlightsToggle<CR>
    noremap <leader>gha :GitGutterSignsEnable<CR>
                \:GitGutterLineHighlightsEnable<CR>
    " GitGutter hunk move/action/git
    nmap <leader>gP <Plug>(GitGutterPreviewHunk)
    nmap <leader>gF :GitGutterFold<CR>
    nmap <leader>gS <Plug>(GitGutterStageHunk)
    nmap <leader>gU <Plug>(GitGutterUndoHunk)
    " Move through hunks in current buffer
    nmap <silent><leader>gj <Plug>(GitGutterNextHunk)zz
    nmap <silent><leader>gk <Plug>(GitGutterPrevHunk)zz
endif

" ============================================================================
" Part 7 - Python coding tools settings (Plugins settings and mappings)
" ============================================================================
" Python coding tools settings, edit them as you wish.

" Deoplete -------------------------------------------------------------------
" Front end for python completion
if using_python_completion
    " Pynvim is needed [Installation: pip3 install --user pynvim]
    " Needed so deoplete can auto select the first suggestion
    set completeopt+=noinsert
    " Comment this line to enable autocompletion preview window
    " (displays documentation related to the selected completion option)
    " Disabled by default because preview makes the window flicker
    set completeopt-=preview
    " Python that uses to install jedi
    let g:python3_host_prog = python_for_completion
    " Enable deoplete at startup
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
    " Goto variable definition
    let g:jedi#goto_command = '<leader>pd'
    " Find all usages of variable name
    let g:jedi#usages_command = '<leader>pn'
    " Rename variable name
    let g:jedi#rename_command = '<leader>pr'
    " Goto stubs
    let g:jedi#goto_stubs_command = '<leader>ps'
    " Find variable assignments (Goto function)
    let g:jedi#goto_assignments_command = '<leader>pa'
    " Open python module [show __init__.py]
    autocmd FileType python
                \ noremap <leader>pm
                \ :execute ":Pyimport " . expand('<cword>')<CR>
    autocmd FileType python noremap <leader>pM :Pyimport<space>
endif

" Python syntax --------------------------------------------------------------
" Add more syntax highlight for python
let g:python_highlight_all = 1

" Python debug (add python breakpoints) --------------------------------------
" [ipdb must be installed first]
" -- Installaion in termianl: run 'pip install ipdb'
if using_python_completion
    autocmd FileType python
                \ noremap <silent><leader>pb Oimport ipdb;
                \ ipdb.set_trace()<Esc>
endif

" ============================================================================
" Part 8 - Other language coding tools settings (Plugin settings and mappings)
" ============================================================================
" Other language support settings, edit them as you wish.
" Language support: Fortran, LaTex, Html, Markdown

" Fortran --------------------------------------------------------------------
" Ensure correct highlighting for
" Fortran free-form source code and turn syntax highlighting on
let fortran_free_source = 1
let fortran_do_enddo = 1

" LaTex ----------------------------------------------------------------------
" Set spell check for LaTex files
" -- z= :Correct spell
autocmd FileType tex setlocal spell
autocmd FileType tex setlocal updatetime=10000 " Unit: milisecond
" Latex realtime viewer with gui pdf file manager
if using_gui_software
    let g:livepreview_previwer = 'okular'
    let g:livepreview_engine = 'pdflatex'
    autocmd BufEnter *.tex echom '[Press F4 to Preview .tex File]'
    autocmd FileType tex noremap <F4> :LLPStartPreview<CR>
endif

" Markdown -------------------------------------------------------------------
" Set spell check for markdown files
autocmd FileType markdown setlocal spell

" Markdown previewer (no extra vim plugin needed)
" From https://krehwell.com/blog/Open%20Markdown%20Previewer%20Through%20Vim
" Google-chrome extension is needed for markdown viewer
if using_gui_software && !using_vim8
    let $VIMBROWSER='brave-browser'
    let $OPENBROWSER='noremap <F4> :!'. $VIMBROWSER .' %:p &<CR>'
    autocmd BufEnter *.md echom '[Press F4 to Open .md File]'
    autocmd BufEnter *.md exe $OPENBROWSER
endif

" Synchronous markdown previewer (markdown-preview plugin)
if using_gui_software && using_vim8
    " Web browser used to preview
    let g:mkdp_browser = 'brave-browser'
    " Show url of markdown previewer
    let g:mkdp_echo_preview_url = 1
    autocmd BufEnter *.md echom '[Press F4 to Open .md File]'
    autocmd BufEnter *.md nmap <F4> <Plug>MarkdownPreviewToggle<CR>
endif

" ============================================================================
" Part 9 - Colorscheme and other color settings (Plugin settings and mappings)
" ============================================================================
" Set colorscheme (syntax highlight), color assignment, and etc.

" Vim colorscheme ------------------------------------------------------------
" Customized color palette
function! CustomizedColorPalette()
    " Common background setting (dark background)
    set bg=dark
    " Color setup (hi command must be added after colorscheme)
    highlight Comment       cterm=italic ctermfg=8    ctermbg=NONE gui=italic guifg=#8a8a8a guibg=NONE
    highlight CursorColumn  cterm=NONE   ctermfg=NONE ctermbg=234  gui=NONE   guifg=NONE    guibg=#444444
    highlight CursorLine    cterm=NONE   ctermfg=NONE ctermbg=234  gui=NONE   guifg=NONE    guibg=#444444
    highlight CursorLineNr  cterm=bold                ctermbg=NONE gui=bold                 guibg=NONE
    highlight FoldColumn    cterm=NONE   ctermfg=NONE ctermbg=NONE gui=NONE   guifg=NONE    guibg=NONE
    highlight LineNr        cterm=bold   ctermfg=8    ctermbg=NONE gui=bold   guifg=#808080 guibg=NONE
    "highlight Normal        cterm=NONE   ctermfg=NONE ctermbg=NONE gui=NONE   guifg=NONE    guibg=NONE
    highlight OverLength    cterm=bold   ctermfg=15   ctermbg=9    gui=bold   guifg=#ffffff guibg=#ff0000
    highlight Pmenu         cterm=bold   ctermfg=8    ctermbg=NONE gui=bold   guifg=#808080 guibg=NONE
    highlight SignColumn    cterm=NONE   ctermfg=NONE ctermbg=NONE gui=NONE   guifg=NONE    guibg=NONE
    highlight UnlimitLength cterm=NONE   ctermfg=NONE ctermbg=NONE gui=NONE   guifg=NONE    guibg=NONE
endfunction

" Vim colorscheme ------------------------------------------------------------
" Customized colorscheme settings
if using_customized_theme
    if using_wal_theme
        " Option 1 - Direct read Xcolor from wal
        "source $HOME/.cache/wal/colors-wal.vim
        " Option 2 - Use wal vim plugin [Recommended]
        colorscheme wal
        " Lightline style
        call LightlineStyle('wal', 1, 1)
    else
        " Current available themes
        colorscheme gruvbox
        " Lightline style
        call LightlineStyle('gruvbox', using_fancy_symbols, 1)
    endif
    " Call customized color palette
    call CustomizedColorPalette()
    " Comment below Normal for non-transparent background
    highlight Normal
                \ cterm=NONE ctermfg=NONE ctermbg=NONE
                \ gui=NONE guifg=NONE guibg=NONE
    " Cursor line number highlight for wal theme
    if using_wal_theme
        highlight CursorLineNr cterm=bold ctermfg=10 ctermbg=NONE
    endif
endif
" Colorschmeme shortcut
nnoremap <leader>csd :colorscheme default<CR>:set termguicolors<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineStyle('default', using_fancy_symbols, 0)<CR>
            \:call LightlineReload()<CR>:echo "default colorscheme"<CR>
nnoremap <leader>csg :colorscheme gruvbox<CR>:set termguicolors<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineStyle('gruvbox', using_fancy_symbols, 1)<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineReload()<CR>:echo "gruvbox colorscheme"<CR>
nnoremap <leader>csv :colorscheme vim-monokai-tasty<CR>:set termguicolors<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineStyle('deus', using_fancy_symbols, 0)<CR>
            \:call LightlineReload()<CR>:echo "monokai colorscheme"<CR>
nnoremap <leader>css :colorscheme srcery<CR>:set termguicolors<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineStyle('srcery_drk', using_fancy_symbols, 1)<CR>
            \:call LightlineReload()<CR>:echo "srcery colorscheme"<CR>
nnoremap <leader>csn :colorscheme nord<CR>:set termguicolors<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineStyle('nord', using_fancy_symbols, 1)<CR>
            \:call LightlineReload()<CR>:echo "nord colorscheme"<CR>
nnoremap <leader>cso :colorscheme OceanicNext<CR>:set termguicolors<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineStyle('oceanicnext', using_fancy_symbols, 1)<CR>
            \:call LightlineReload()<CR>:echo "oceanicnext colorscheme"<CR>
nnoremap <leader>csw :colorscheme wal<CR>:set notermguicolors<CR>
            \:call CustomizedColorPalette()<CR>
            \:call LightlineStyle('wal', 1, 1)<CR>
            \:highlight CursorLineNr cterm=bold ctermfg=10 ctermbg=NONE<CR>
            \:call LightlineReload()<CR>:echo "wal colorscheme"<CR>
" Transparent background shortcut
nnoremap <leader>cst :highlight Normal cterm=NONE ctermfg=NONE ctermbg=NONE
            \ gui=NONE guifg=NONE guibg=NONE<CR><CR>
            \:echo "transparent background"<CR>

" ============================================================================
" End of Vim configuration, automatically reload current config after saving
" ============================================================================
" Automated run vim configuration file just after saving ---------------------
"autocmd BufWritePost $MYVIMRC source $MYVIMRC
