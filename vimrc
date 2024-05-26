" ~/.vimrc
" vim: syntax=vim ft=vim ff=unix
" ============================================================================
" Fisa-vim-config
" http://fisadev.github.io/fisa-vim-config/
" Modified [Vim]/[Neovim] version: >= [8.2]/[v0.4.4]
" by Kuan-Hsien Wu, Sheng-Jun Lin
" ============================================================================
" This vim configuration is for both vim and neovim

" NOTE: Vim / Neovim configuration file --------------------------------------
    " Vim configuration file
    " -- Store in ~/.vimrc
    " Neovim configuration file
    " -- Store in ~/.config/nvim/init.vim

" ============================================================================
" Vim and Neovim configuration notes
" ============================================================================
" Followings are problems, recommended solutions, and plugin-function support
" notes for configuration

" NOTE: Old powerline-status support [Not use anymore, use lightline now] ----
    " Powerline-status installation (Choose one of the followings)
    " (1) sudo install vim-powerline (Fedora)
    " (2) sudo apt-get install powerline (Ubuntu)
    " (3) activate manually
    "     -- python3 from powerline.vim import setup as powerline_setup
    "     -- python3 powerline_setup()
    "     -- python3 del powerline_setup

" NOTE: Special character support --------------------------------------------
    " NERDFont installation (Step by step)
    " (1) mkdir -p ~/.local/share/fonts
    " (2) cd ~/.local/share/fonts && curl -fLo \
    "     "Droid Sans Mono for Powerline Nerd Font Complete.otf" \
    "     https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/\
    "     DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
    " (3) [No needs for kitty] set terminal font to "DroidSansMono Nerd Font"

" NOTE: Vim plugin support ---------------------------------------------------
    " If curl is installed, vim-plug (vim-plugin manger) should automatically
    " run all installation at your first time loading vim.

    " If vim-plug somehow not working automatically or if you want manual
    " installation, in vim command mode, type :PlugInstall

" NOTE: Vim features support -------------------------------------------------
    " In Fedora, vim is complied without clipboard and python3/dyn features,

    " For those feature support, you can try either recompile vim from source
    " codes or [Recommended] just install gvim (gui-vim) from Fedora instead.
    " Also, xclip or parcellite MUST be installed [dnf install xclip/parcellite]

" NOTE: Leader key delay solution---------------------------------------------
    " In the following configuration, I use space as leader key, however, it
    " will encounter delay problem in insert mode (Need wait for a while to
    " insert space character) since vim always waits to see if you want to
    " press more keys to execute some function mapped in insert mode.

    " For now, there are two solutions: One is to set leader key to other key
    " than space; The other one (RECOMMENDED) is to remap all keymaps in
    " INSERTMODE (vim command :imap) that start with space

" NOTE: Neoformat (Formatter) ------------------------------------------------
    " Call multi-language code formatter [formatter need to be installed]
    " Also need to make sure that formatter is executable [e.g. pyment]
    " For code formatter support: https://github.com/sbdchd/Neoformat

    " Example: python code formatter
    " -- Install formatter with terminal:
    "    (1) pip install isort
    "    (2) pip install pyment
    "    (3) pip install yapf
    " -- Use formatter in vim command line:
    "    -- Usage :Neoformat! [language] [formatter]
    "    --  e.g. :Neoformat!   python       yapf
    " -- Recommended PYTHON usage set (in order):
    "    -- (1) :Neoformat isort  # Sort import module
    "    -- (2) :Neoformat pyment # Add description of function/class
    "    -- (3) :Neoformat yapf   # Format to PEP8 standard

" NOTE: Python-completion and tmux-yank-clipboard on remote machine ----------
    " Use neovim and everything is fine, but notice that neovim support of
    " Fedora repo is for Fedora 25 and higher version. For now, Seb just used
    " AppImage directly from neovim website

    " Python-completion dependence
    " -- jedi-vim: pip install jedi
    " -- deoplete: pip install pynvim neovim
    " -- ipython : pip install ipython (version >= 7.2)

    " Python packages already installed in somewhere else
    " -- Use: pip install (--user) --ignore_installed <PACKAGE_NAME>

" NOTE: Keyboard key repeat time settings ------------------------------------
    " Speed up/down key repeat time for pressing key
    " -- e.g jjjjjjjj, kkkkkkkkkk, wwwwwwwwwww
    " Use Xset to set key repeat
    " --      xset [repeat rate] [start repeat time (ms)] [repeat rate (/sec)]
    " -- e.g. xset     r rate              300                    40

" NOTE: Edit file on remote machine ------------------------------------------
    " SCP (via SSH connection)
    " -- :edit scp://user@remote_machine//path_to_file

" ============================================================================
" Vim and Neovim settings (***MUST-READ SESSION***)
" ============================================================================
" Select vim-plug to load, set guicolor (real color) support, and etc.

" Options for my vim/neovim configuration ------------------------------------
    " Use vim or neovim (Auto-detect)
    let USING_NEOVIM = has('nvim')
    let USING_VIM = !USING_NEOVIM
    " Check if vim version >= 8.0 (also for neovim >= 0.5)
    let USING_VIM8 = 1
    " Customize vim theme (Include colortheme and statusline)
    let USING_CUSTOMIZED_THEME = 1
    " Fancy symbols (Mainly affect lightline and nerdtree icon)
    let USING_FANCY_SYMBOLS = 0
    " Wal theme support (Xresources colortheme support, check pywal)
    let USING_WAL_THEME = 0
    " Extra vim-plug (Include easymotion, yankring, autocomplpop, and etc.)
    let USING_EXTRA_PLUG = 1
    " Coding tools vim-plug (Include syntax support, git function, and etc.)
    let USING_CODING_TOOL_PLUG = 1
    " Language Server Protocal (LSP) (Include completion, linting and etc.)
    let USING_LSP = 1
    " Python Completion (Use deoplete and jedi, neovim is recommended)
    let USING_PYTHON_COMPLETION = !USING_LSP
    " Support of external gui software (e.g. Okular, Google-chrome, and etc.)
    let USING_GUI_SOFTWARE = 1
    " Add python skeleton file to newly created .py python file
    let USING_PYTHON_SKELETON = 1
    " Add Tex template file to newly created .tex tex file
    let USING_TEX_TEMPLATE = 1
    " Add markdown template file to newly created .md markdown file
    let USING_MARKDOWN_TEMPLATE = 1

" Variables for vim/neovim or plug-in ----------------------------------------
    " Web browser for markdown preview
    let s:WEBBROWSER = $BROWSER
    " Ctag generator for vimwiki plugins
    let s:CTAGSBIN = '$HOME/Desktop/Vim_Tmux_Config/bin/vwtags.py'
    " FZF patches for change/jump list
    let s:FZF_PATCH = '$HOME/Desktop/Vim_Tmux_Config/vim/patch/fzf_patch.vim'
    " Python that has jedi, pynvim and packages installed for completion
    let s:PYTHON_FOR_COMPLETION = '/usr/bin/python' "$CONDA_PYTHON_EXE
    " Python skeleton file (template)
    let s:PYTHON_SKELETON = '$HOME/Desktop/Vim_Tmux_Config/share/skeleton.py'
    " Tex template file
    let s:TEX_TEMPLATE = '$HOME/Desktop/Vim_Tmux_Config/share/template.tex'
    " Markdown Template file
    let g:MARKDOWN_NOTE_TEMPLATE = '$HOME/Desktop/Vim_Tmux_Config/share/note_template.md'
    let g:MARKDOWN_TEMPLATE = g:MARKDOWN_NOTE_TEMPLATE
    " HTML Table template
    let g:MARKDOWN_TABLE_TEMPLATE = '$HOME/Desktop/Vim_Tmux_Config/share/table.html'

" TERMGUI color --------------------------------------------------------------
    " Ctermcolors only support max 256 color
    " Termguicolors can support HTML color code

    " Wal colortheme does not work well with termguicolors
    if has('termguicolors') && !USING_WAL_THEME
        set termguicolors
    endif
    " 256 term color support in vim TUI
    if !has('gui_running')
        set t_Co=256
    endif

" ============================================================================
" Vim built-in function settings and vim hotkeys settings
" ============================================================================
" All parameter settings and hotkey mappings
    " NOTE:
    " -- Ctrl+i (Tab)
    " -- Ctrl+[j/m] (Enter)

" Vim built-in filetype setting ----------------------------------------------
    " Following settings are later automatically executed by VIM-plug
    " -- filetype plugin on
    " -- filetype indent on
    " -- syntax enable
    filetype off

" Set leaderkey --------------------------------------------------------------
    " Default leaderkey '\'
    let mapleader = ' '

" Map insert mode key --------------------------------------------------------
    " NOTE:
    " -- Ctrl+j (Enter)
    " -- Ctrl+o (Execute single normal mode operation)
    " -- Ctrl+r+(register) (Paste register)
    " -- Ctrl+[n/p] (Autocompletion next/prev candidate)
    " -- Ctrl+[d/t] (Unindent/Indent current line)

    " Map exit insert mode (Esc/Ctrl+[) to ii, kj
    " -- Use Ctrl+[q/v] to escape for 'ii' word (e.g. ascii)
    "imap ii <Esc>
    imap kj <Esc>
    " <C-g>u: add break point for text-writing undo
    " -- e.g. w/o bp: test,test,test --undo->
    " -- e.g. w/i bp: test,test,test --undo-> test,test,
    inoremap , ,<C-g>u
    inoremap . .<C-g>u
    inoremap ? ?<C-g>u
    inoremap ! !<C-g>u

" Map normal/visual/operator-pending mode key --------------------------------
    " NOTE:
    " -- z+[t/z/b/h/l]: scroll window top/center/bottom/left/right
    " -- Ctrl+[i/o]: jump to next/prev cursor location
    " -- :ju[mps]: show all jump history
    " -- g+[;/,]: go to older/newer change
    " -- :changes: show all change history
    " -- g+[-/+]: go to prev/next text-states (undo/redo)
    " -- g+[j/k/l/h]: move in visual lines instead of real lines in WRAP text
    " -- g+[uu/UU/~~]: set lowercase/uppercase/toggle for whole line
    " -- :g/PATTERN/ACTION: in entire file, for lines matched PATTERN, do ACTION
    " -- :v/PATTERN/ACTION: in entire file, for lines do not matched PATTERN, do ACTION
    " -- g+[t/T]: go to next/prev tab
    " -- g+[i]: go to last location in insert mode and enter insert mode
    " -- g+[v]: go to last location in visual mode and enter visual mode
    " -- g+[n]: go to next search and visually select it
    " -- g+[f]: go to file
    " -- g+Ctrl+g: count words

    " Unmap q-key related keybindings to prevent typo when quitting/closing
    " -- :<C-f>: open command mode history
    " -- /<C-f>: open search history
    map gQ <nop>
    map q: <nop>
    nnoremap Q <nop>
    " Make Y yank to the EOL instead of whole line just like what D does
    nnoremap Y y$
    " Stop delete/change/replace overwriting current register
    "nnoremap d "_d
    "nnoremap x "_x
    nnoremap r "_r
    " Move selection block up/down in visual mode
    vnoremap K :m '<-2<CR>gv=gv
    vnoremap J :m '>+1<CR>gv=gv
    " Tab is already mapped to <C-i> by vim
    noremap <Tab> <C-i>
    noremap <S-Tab> <C-o>
    noremap gi <C-i>
    noremap go <C-o>
    " Show jump list
    noremap <leader>go :jumps<CR>
    noremap <leader>gi :jumps<CR>
    " Show change list
    noremap <leader>g; :changes<CR>
    noremap <leader>g, :changes<CR>
    " Diff mode (vimdiff or nvim -d)
    noremap <leader>dd :diffthis<CR>
    noremap <leader>do :diffoff<CR>
    noremap <leader>ds :diffsplit<space>
    noremap <leader>dv :vertical diffsplit<space>
    noremap <leader>dg :diffget<CR>
    noremap <leader>dp :diffput<CR>
    noremap <leader>du :diffupdate<CR>
    noremap <leader>dj ]c
    noremap <leader>dk [c
    " Inline substitution (press & to repeat last substitution action)
    vnoremap gs :s/\<<c-r><c-w>\>//g<left><left>
    nnoremap gs :s/\<<c-r><c-w>\>//g<left><left>
    nnoremap gS :%s/\<<c-r><c-w>\>//g<left><left>

" Save/Load file hotkey ------------------------------------------------------
    " NOTE:
    " -- ZZ (Quit and save if there's change in file without confirmation)
    " -- :f <new-filename> (Save current file with new filename)
    " -- :earlier Nf (Undo to last N file change)
    " -- :later Nf (Redo to N file change)

    noremap <leader>qq :q<CR>
    noremap <leader>q! :q!<CR>
    noremap <leader>qa :qall<CR>
    noremap <leader>qa! :qall!<CR>
    noremap <leader>ww :call RemoveTrailingWhitespace()<CR>:w<CR>
    noremap <leader>w! :call RemoveTrailingWhitespace()<CR>:w!<CR>
    noremap <leader>wq :call RemoveTrailingWhitespace()<CR>:wq<CR>
    noremap <leader>wa! :wall!<CR>
    noremap <leader>wa :wqall<CR>

" External command -----------------------------------------------------------
    " NOTE:
    " -- :r !date (Insert time stamp)
    " -- :r !seq [START] [INCREMENT] LAST (Insert number sequence)
    " -- :!dir (Show current directory file)
    " -- :!del FILENAME (Delete FILENAME)
    " -- :!column --table (Columnated selected context in visual mode)
    " -- :!sort (Sort selected context in visual mode alphabetically)

    " Add number sequence
    nnoremap <leader>esq :r !seq<space>
    " Add time stamp
    nnoremap <leader>ets :r !date<CR>
    " Sort selected context alphabetically
    vnoremap <leader>est :!sort<CR>
    " Filter out unique word [Context should be sorted first]
    vnoremap <leader>euq :!uniq<CR>

" General Vim settings -------------------------------------------------------
    set exrc            " Search vimrc file in current directory
    set timeoutlen=300  " Timeout for entering combined key (millisecond)
    set confirm         " Ask for confirmation before leaving vim
    set modifiable      " Make current buffer modifiable
    set encoding=utf-8  " Unicode display support
    set notildeop       " Not make ~ a operator like gu, gU, and etc.
    set lazyredraw      " Only redraw when necessary.
    set shell=/bin/bash " Set default shell for vim/neovim (for navigator)
    set mouse=          " Disable mouse function
    set backspace=indent,eol,start     " Backspace through everything
    set clipboard^=unnamed,unnamedplus " Shared system clipboard (+clipboard)
    "set dictionary+=/usr/share/dict/words " Dictionary for word completion
    set tags=./.tags,.tags;/ " use ctag -o .tags -R . to generate file tags

" Vim only settings ----------------------------------------------------------
    if USING_VIM
        set nocompatible " Not compatible with vi [No need for neovim]
        set ttyfast      " Faster redrawing. [Removed in neovim]
    endif

" Neovim only settings -------------------------------------------------------
    if USING_NEOVIM
        set inccommand=nosplit " Enable incremental command without split pane
    endif

" Working directory ----------------------------------------------------------
    set autochdir " Change working directory to current buffer file directory
    noremap <leader>ac :set autochdir!<CR>

" Line wrap ------------------------------------------------------------------
    set nowrap " Line wrap for small monitor or display window
    noremap <leader>wp :set wrap!<CR>

" Word -----------------------------------------------------------------------
    noremap <leader>w- :set iskeyword-=_<CR>
    noremap <leader>w= :set iskeyword+=_<CR>

" Spell check ----------------------------------------------------------------
    " NOTE:
    " -- [g] for good, [w] for wrong, [a] for add, [r] for remove
    set nospell " Vim built-in spell check
    noremap <leader>sl :set spell!<CR>
    noremap <leader>sag <Esc>zg
    noremap <leader>saw <Esc>zw
    noremap <leader>srg <Esc>zug
    noremap <leader>srw <Esc>zuw
    noremap <leader>sj ]s
    noremap <leader>sk [s

" Wild menu settings ---------------------------------------------------------
    set wildmenu           " Show menu options
    set wildmode=list:full " Show all available input options (or use Ctrl-D)

" Show special characters ----------------------------------------------------
    set list " Show character in list
    set listchars=eol:↵,tab:»·,trail:╳,extends:»,precedes:«,nbsp:␣
    noremap <leader>cl :set list!<CR>

" Cursor settings ------------------------------------------------------------
    set ruler          " Show cursor position in status line
    set cursorline     " Show horizontal line
    set nocursorcolumn " Show vertical line (laggy sometimes)
    " Toggle cursor line/column indicator (horizontal/vertical)
    noremap <leader>ch :set cursorline!<CR>
                \:echo 'Toggle Cursor Line [Horizontal]'<CR>
    noremap <leader>cv :set cursorcolumn!<CR>
                \:echo 'Toggle Cursor Column [Vertical]'<CR>
    " Synchronize cursor between files
    " Must be executed in all files that you want to synchronize cursors
    noremap <F11> :set cursorbind<CR>
    noremap <leader><F11> :set nocursorbind<CR>

" Display settings -----------------------------------------------------------
    set title             " Let vim change terminal title
    set display+=lastline " Show line as much as possible
    set scrolloff=10      " Keep cursor 10 lines away from top and bottom
    " Change scroll off
    noremap <leader>so0 :set scrolloff=10<CR>
    noremap <leader>so- :set scrolloff=0<CR>
    noremap <leader>so= :set scrolloff=999<CR>

" Search settings ------------------------------------------------------------
    " NOTE:
    " -- Ctrl+[t/g]: Go to prev/next matching result in incsearch
    " -- [+I: Show lines with matching words in current buffer
    " -- ]+I: Show lines with matching words after current line in current buffer

    set incsearch  " Incremental search (character-by-character search)
    set hlsearch   " Highlight search result
    set ignorecase " Close case sensitive [Needed for smartcase]
    set smartcase  " Case sensitive if search contains uppercase letter
    noremap <M-/> :set nohlsearch!<CR>

" Line number settings -------------------------------------------------------
    set numberwidth=4    " Set fixed width to number column
    set norelativenumber " Do not show relative line number
    set number           " Show absolute line number
    " Toggle absolute/relative line number
    noremap <leader><F5> :set number!<CR>
    noremap <F5> :set relativenumber!<CR>

" View/Session settings ------------------------------------------------------
    " NOTE:
    " -- View (stored at ~/.local/state/nvim/view)
    "    -- viewoptions: folds,cursor,curdir
    " -- Session (save more info and can be stored anywhere),
    "    -- sessionoptions: blank,buffers,curdir,folds,help,tabpages,winsize,terminal
    noremap <F10> :mkview<CR>
    noremap <leader><F10> :loadview<CR>
    noremap <C-s> :mksession<space>

" Fold settings --------------------------------------------------------------
    " NOTE:
    " -- z+[c/o]: Close/Open current fold
    " -- z+[C/O]: Close/Open current fold recursively
    " -- z+[m/r]: More/Reduce fold level
    " -- z+[M/R/i]: Maximize/Remove/Invert all folds
    " -- z+[j/k]: Jump to next/prev fold

    " Default fold settings
    set foldmethod=manual
    set foldcolumn=0
    set foldlevel=0
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
    nnoremap <F6> :call FoldColumnToggleShort()<CR>
    nnoremap <leader><F6> :call FoldColumnToggleLong()<CR>

" Window settings ------------------------------------------------------------
    " NOTE:
    " -- Split pane navigation [Now integrate with tmux, check vim-tmux-navigator]
    "    -- <C-w>[h/j/k/l]: Move to L/D/U/R pane
    "    -- <C-w>[H/J/K/L]: Move pane to L/D/U/R
    " -- Split pane action (built-in, extended)
    "    -- <C-w>T: Move current pane to new tab
    "    -- <C-w>n: Add new empty pane
    "    -- <C-w>[q/c]: Close current pane
    "    -- <C-w>[s/v]: Open current buffer in split/vsplit
    " -- Split pane resize (built-in, extended)
    "    -- <C-w>[+/-]: Increase/Decrease current pane height
    "    -- <C-w>[>/<]: Increase/Decrease current pane width
    "    -- <C-w>[_/|]: Maximize current pane horizontally/vertically
    " -- Miscellaneous
    "    -- <C-w><C-f>: Open selected file in horizontal split
    "    -- <C-w>w: Cycle through all panes
    "    -- <C-w>o: Close all other window panes
    "    -- :sfind FILENAME: Open split with FILENAME

    " Split pane - Split border style
    set fillchars+=vert:\ "
    " Split pane - More natural split opening
    set splitbelow
    set splitright
    " Resize window
    noremap <silent><A-l> :vertical resize +2<CR>
    noremap <silent><A-h> :vertical resize -2<CR>
    noremap <silent><A-j> :resize +2<CR>
    noremap <silent><A-k> :resize -2<CR>

" Tab (window container) settings --------------------------------------------
    " List tabs
    noremap <leader>ts :tabs<CR>
    " Open new tab in background
    noremap <leader>ta :tabnew<space>
    " Open new tab in foreground
    noremap <leader>te :tabedit<space>
    noremap <leader>tf :tabfind<space>
    " Close tab
    noremap <leader>td :tabclose<CR>
    noremap <leader>tD :tabclose<space>
    " Navigate through tabs
    noremap <leader>t0 :tabfirst<CR>
    noremap <leader>t$ :tablast<CR>
    noremap <leader>tn :tabnext<CR>
    noremap <leader>tp :tabprevious<CR>
    " Swap tabs
    noremap <leader>tN :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
    noremap <leader>tP :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    " Merge into one tab
    noremap <leader>to :tabonly<CR>
    " Split buffers into individual tabs
    noremap <leader>tO :tab ball<CR>
    "Action for all tabs (tabdo)
    noremap <leader>tbd :tabdo<space>

" Buffer settings ------------------------------------------------------------
    " Switch buffers without saving
    set hidden
    " List all buffers
    noremap <leader>bs :buffers<CR>
    " Add buffer in background
    noremap <leader>ba :badd<space>
    " Add buffer in foreground (use :edit! to give up all changes)
    noremap <leader>be :edit<space>
    " Delete buffer
    noremap <leader>bd :bdelete<CR>
    noremap <leader>bD :bdelete<space>
    " Undo buffer to last save
    noremap <leader>bu :edit!<CR>
    " Navigate through buffers
    noremap <leader>b0 :bfirst<CR>
    noremap <leader>b$ :blast<CR>
    noremap <leader>bp :bprev<CR>
    noremap <leader>bn :bnext<CR>
    " Actions for all buffers (bufdo)
    noremap <leader>bfd :bufdo<space>

" Args settings --------------------------------------------------------------
    " List args
    noremap <leader>as :args<CR>
    " Reset args with new input arguments
    noremap <leader>aS :args<space>
    " Add file to args in background
    noremap <leader>aa :argadd %<CR>:args<CR>
    noremap <leader>aA :argadd<space>
    " Add file to args and edit in foreground
    noremap <leader>ae :argedit<space>
    " Delete file from args
    noremap <leader>ad :argdelete %<CR>:args<CR>
    noremap <leader>aD :argdelete<space>
    " Navigate through args
    noremap <leader>a0 :first<CR>:args<CR>
    noremap <leader>a$ :last<CR>:args<CR>
    noremap <leader>an :next<CR>:args<CR>
    noremap <leader>ap :prev<CR>:args<CR>
    " Do actions to all files in args
    noremap <leader>agd :argdo<space>

" Quickfix list settings ------------------------------------------------------
    " Function to toggle quickfix list pane
    let g:quickfix_list_is_open = 0
    function! QuickfixListToggle()
        if g:quickfix_list_is_open
            cclose
            let g:quickfix_list_is_open = 0
        else
            copen
            let g:quickfix_list_is_open = 1
        endif
    endfunction
    " Keymapping for quickfix list
    noremap <leader>qg :vimgrep<space>
    noremap <leader>qd :cdo<space>
    noremap <leader>qo :call QuickfixListToggle()<CR>
    noremap <leader>qj :cnext<CR>zz
    noremap <leader>qk :cprev<CR>zz

" Location list settings ------------------------------------------------------
    " Function to toggle location list pane
    let g:location_list_is_open = 0
    function! LocationListToggle()
        if g:location_list_is_open
            lclose
            let g:location_list_is_open = 0
        else
            lopen
            let g:location_list_is_open = 1
        endif
    endfunction
    " Keymapping for location list
    noremap <leader>eg :lvimgrep<space>
    noremap <leader>eo :call LocationListToggle()<CR>
    noremap <leader>ej :lnext<CR>zz
    noremap <leader>ek :lprev<CR>zz

" Marks settings -------------------------------------------------------------
    " NOTE:
    " -- Mark should start with ' (single quotation) or ` (grave symbol)
    "    -- '' : Last cursor location
    "    -- '" : Last cursor location when buffer closed
    "    -- '. : Last modification
    "    -- '[ : Beginning of last yanked text (] for end)
    "    -- '< : Beginning of last visual selection (> for end)

    " Show marks in vim [Also check markbar plugin]
    noremap <leader>mk :marks<CR>
    noremap <leader>md :delmarks<space>
    noremap <leader>mdd :delmarks!<CR>

" Registers settings ---------------------------------------------------------
    " NOTE:
    " -- Register should start with " (double quotation)
    "    -- ": : Last command
    "    -- ". : Last text
    "    -- "% : Current filename
    "    -- "/ : Last search

    " Show registers in vim [Also check peekaboo plugin]
    noremap <leader>rr :registers<CR>
    " Command that wipe out all registers
    command! WipeReg for i in range(34,122) |
                \ silent! call setreg(nr2char(i), []) | endfor

" Abbreviation settings ------------------------------------------------------
    " NOTE:
    " -- :abbclear : Clear abbreviation

    " Show abbreviate in vim
    noremap <leader>ab :abbreviate<CR>

" Better backup, swap and undoes storage -------------------------------------
    if USING_NEOVIM
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

" Function - no system bell --------------------------------------------------
    set visualbell   " ┐
    set noerrorbells " │ Disable beeping and window flashing
    set t_vb=        " ┘ https://vim.wikia.com/wiki/Disable_beeping

" Function - autoremove whitespace in end of line ----------------------------
    " -- Remove trailing whitespace when writing a buffer, but not for diff files
    " -- From Vigil <vim5632@rainslide.net>
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
    "autocmd BufWritePre * call RemoveTrailingWhitespace()

" Function - hex editor ------------------------------------------------------
    " -- From https://blog.gtwang.org/useful-tools/how-to-use-vim-as-a-hex-editor/
    noremap <leader>eho :%! xxd<CR>
                \:echo 'Hex editor on: TF to binary data'<CR>
    noremap <leader>ehf :%! xxd -r<CR>
                \:echo 'Hex editor off: TF to original data'<CR>

" Function - over-length column color warnings -------------------------------
    let g:overlength_column_is_open = 0
    " Toggle over-length function
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
    " Toggle over-length column color
    nnoremap <F7> :call OverlengthColumnToggle()<CR>

" Function - over-length character color warnings ----------------------------
    " Here adopt default vim text width 78 characters as maximum line length
    " Default value (disabled at startup)
    let g:overlength_warning_is_open = 0
    " Toggle over-length function
    function! OverlengthToggle()
        if g:overlength_warning_is_open
            match UnlimitLength /\%79v.\+/
            echo 'Over 78 character line highlight OFF'
            let g:overlength_warning_is_open = 0
        else
            match OverLength /\%79v.\+/
            echo 'Over 78 character line highlight ON'
            let g:overlength_warning_is_open = 1
        endif
    endfunction
    " Toggle over-length
    nnoremap <leader><F7> :call OverlengthToggle()<CR>

" Function - comment highlight -----------------------------------------------
    " Default value (disabled at startup)
    let g:comment_highlight_is_open = 0
    " Toggle comment highlight function
    function! CommentHighlightToggle()
        if g:comment_highlight_is_open
            highlight Comment cterm=italic ctermfg=8  guifg=#8a8a8a
            echo 'Hi-Comment OFF'
            let g:comment_highlight_is_open = 0
        else
            highlight Comment cterm=italic ctermfg=14 guifg=#00ffff
            echo 'Hi-Comment ON'
            let g:comment_highlight_is_open = 1
        endif
    endfunction
    " Toggle comment highlight
    nnoremap <F8> :call CommentHighlightToggle()<CR>

" Function - fold highlight --------------------------------------------------
    " Default value (disabled at startup)
    let g:comment_fold_is_open = 0
    " Toggle fold highlight function
    function! FoldHighlightToggle()
        if g:comment_fold_is_open
            highlight Folded ctermfg=8  guifg=#8a8a8a
            echo 'Hi-Fold OFF'
            let g:comment_fold_is_open = 0
        else
            highlight Folded ctermfg=13 guifg=#FF2EFF
            echo 'Hi-Fold ON'
            let g:comment_fold_is_open = 1
        endif
    endfunction
    " Toggle fold highlight
    nnoremap <leader><F8> :call FoldHighlightToggle()<CR>

" ============================================================================
" Customized terminal mode (ONLY support for vim >= 8.0)
" ============================================================================
" Vim support built-in terminal, by default use system $SHELL

" Terminal mode - open terminal in vim buffer --------------------------------
    " -- Enter insert mode to use terminal command line
    " -- In terminal buffer, <C-\><C-n> back to normal mode
    " -- In terminal buffer, :bd! to kill terminal buffer

" Set customized terminal mode key mapping -----------------------------------
    if USING_VIM8
        " Map key to enter terminal mode
        if USING_NEOVIM
            noremap <F12> :split<CR>:terminal<CR>i
            noremap <leader>tm :split<CR>:terminal<CR>i
        else
            noremap <F12> :terminal<CR>
            noremap <leader>tm :terminal<CR>
        endif
        " Map key to go back from terminal mode to normal mode
        " Do not use Esc (which conflicts with fzf window) but <C-\><C-n>
        tnoremap <leader><F12> <C-\><C-n>:echo 'Back to Normal Mode'<CR>
        tnoremap <F12> <C-\><C-n>:echo 'Back to Normal Mode'<CR>
        "tnoremap kj <C-\><C-n>:echo 'Back to Normal Mode'<CR>
        tnoremap <C-h> <C-\><C-n><C-w>h
        tnoremap <C-j> <C-\><C-n><C-w>j
        tnoremap <C-k> <C-\><C-n><C-w>k
        tnoremap <C-l> <C-\><C-n><C-w>l
    endif

" ============================================================================
" Vim-plug initialization (Get vim-plug by curl)
" ============================================================================
" Avoid modify this section, unless you are very sure of what you are doing

" Vim-plug (plug-manager). Here curl must be installed first -----------------
    " Setup Vim-Plug path for neovim or vim
    let vim_plug_just_installed = 0
    if USING_NEOVIM
        let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
    else
        let vim_plug_path = expand('~/.vim/autoload/plug.vim')
    endif

    " Install Vim-Plug for neovim or vim
    if !filereadable(vim_plug_path)
        echo 'Installing Vim-plug...'
        echo ''
        if USING_NEOVIM
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

" Declare plug directory -----------------------------------------------------
    " This needs to be here, so vim-plug knows we are declaring the plugins we
    " want to use
    if USING_NEOVIM
        call plug#begin("~/.config/nvim/plugged")
    else
        call plug#begin("~/.vim/plugged")
    endif

" Plugins from github repos:
" ****************************************************************************

" [Vim Neovim communication] -------------------------------------------------
    " Help communicate beteen vim and neovim [needed for deoplete.nvim]
    " Pynvim must be installed first [/usr/bin/python -m pip install pynvim]
    if USING_VIM
        Plug 'roxma/vim-hug-neovim-rpc'
    endif

" [Vim theme] ----------------------------------------------------------------
    if USING_CUSTOMIZED_THEME
        " Wal (Autocolorcheme based on wallpaper) [ONLY work with cterm color]
        Plug 'dylanaraps/wal.vim', { 'on': 'colorscheme wal' }
        " Color theme (Monokai - high contrast)
        Plug 'patstockwell/vim-monokai-tasty',
                    \ { 'on': 'colorscheme vim-monokai-tasty' }
        " Color theme (Gruvbox - low contrast)
        Plug 'morhetz/gruvbox', { 'on': 'colorscheme gruvbox' }
        " Color theme (Srcery - low contrast)
        Plug 'srcery-colors/srcery-vim' ", { 'on': 'colorscheme srcery' }
        " Color theme (Nord - cold color lower contrast)
        Plug 'arcticicestudio/nord-vim', { 'on': 'colorscheme nord' }
        " Color theme (Dracula - medium contrast)
        Plug 'dracula/vim', { 'as': 'dracula'}
        " Lightline (status line)
        Plug 'itchyny/lightline.vim'
        " Lightline bufferline
        Plug 'mengelbrecht/lightline-bufferline'
    endif

" [File/Code browsing] -------------------------------------------------------
    if USING_FANCY_SYMBOLS
        " Nerdtree and other vim-plug powerline symbols support
        Plug 'ryanoasis/vim-devicons'
        " More highlight in nertree
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    endif
    " File browser [support netrw (vim built-in file browser) functions]
    Plug 'scrooloose/nerdtree'
    " Visualize undo history and navigate within them
    Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
    " Code class/module/tag browser [Update to latest]
    Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
    " Code and files fuzzy finder and previewer (main program)
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
    " Code and files fuzzy finder and previewer for vim (vim plugin)
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
    " Large file options
    Plug 'vim-scripts/LargeFile'
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
    " Auto pair for quotations and brackets
    Plug 'jiangmiao/auto-pairs'
    " Show vim keybindings (for now only leader key)
    Plug 'liuchengxu/vim-which-key'
    " Highlight current word and twin words
    Plug 'dominikduda/vim_current_word', { 'on': 'VimCurrentWordToggle' }
    " Pairs of handy bracket mappings (e.g. quickfix list, location list)
    Plug 'tpope/vim-unimpaired'
    " Startup time profiler
    Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }

" [Vim extra functions] ------------------------------------------------------
    if USING_EXTRA_PLUG
        " Goyo (Distraction-free mode)
        Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
        " Limelight (Light-off tool with goyo)
        Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
        " Fancy startup page of vim
        Plug 'mhinz/vim-startify'
        " Vim wiki for knowledge storage
        Plug 'vimwiki/vimwiki'
        " History of yank
        Plug 'vim-scripts/YankRing.vim'
        " Register investigator
        Plug 'junegunn/vim-peekaboo'
        " Mark investigators
        Plug 'Yilin-Yang/vim-markbar', {
                    \ 'on': [ '<Plug>OpenMarkbarPeekabooApostrophe',
                    \ '<Plug>OpenMarkbarPeekabooBacktick' ] }
        " Easymotion (Key-mapping moving in vim)
        Plug 'easymotion/vim-easymotion'
        " Pending tasks list
        Plug 'fisadev/FixedTaskList.vim', { 'on': 'TaskList' }
        " Auto pop-up completion options from vim
        Plug 'vim-scripts/AutoComplPop'
        " Vim-hexokinase only works in termguicolors
        if !USING_WAL_THEME
            " Paint hex colors in color code background color
            Plug 'rrethy/vim-hexokinase', {
                        \ 'do': 'make hexokinase', 'on':'HexokinaseToggle' }
        endif
    endif

" [Vim coding tools] ---------------------------------------------------------
    if USING_CODING_TOOL_PLUG
        if USING_VIM8
            " Additional language packs
            Plug 'sheerun/vim-polyglot'
            if !USING_LSP
                " Multiple language syntax and lint support
                Plug 'dense-analysis/ale', { 'on': 'ALEToggle' }
            endif
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
        " Multiple cursor with extended visual-multi mode
        Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
        " Git integration (Git functions in vim command line)
        Plug 'tpope/vim-fugitive'
        " GitGutter (enhanced signify), also with git integration
        Plug 'airblade/vim-gitgutter',
                    \ { 'on': ['GitGutterToggle', 'GitGutterEnable'] }
    endif

" [Tmux] ---------------------------------------------------------------------
    " Clipboard sharing [No need if already using xclip for tmux clipboard]
    "" Share focus between vim and tmux for clipboard sharing
    "Plug 'tmux-plugins/vim-tmux-focus-events'
    "" Share clipboard between vim and tmux
    "Plug 'roxma/vim-tmux-clipboard'
    " Navigate seamlessly in vim and tmux (Ctrl+h/j/k/l)
    Plug 'christoomey/vim-tmux-navigator'

" [LSP] ----------------------------------------------------------------------
   " Language Server Protocol (LSP)
   if USING_LSP && USING_VIM8
        Plug 'prabirshrestha/vim-lsp'
        Plug 'mattn/vim-lsp-settings'
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
    endif

" [Python coding] ------------------------------------------------------------
    if USING_PYTHON_COMPLETION && !USING_LSP
        " Yet Another Remote Plugin Framework for Neovim [needed for deoplete]
        Plug 'roxma/nvim-yarp', { 'for': 'python' }
        " Front end of completion (python and etc.)
        Plug 'Shougo/deoplete.nvim', { 'for': 'python' }
        " Python autocompletion
        Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
        " Just to add go-to-definition and similar features, autocompeletion
        " from this plugin is disabled
        Plug 'davidhalter/jedi-vim', { 'for': 'python' }
        " Update for the first time usage
        if vim_plug_just_installed
            Plug 'Shougo/deoplete.nvim',
                            \ { 'do': ':autocmd VimEnter * UpdateRemotePlugins' }
        endif
    endif

" [Fortran coding] -----------------------------------------------------------
    " Fortran syntax support
    Plug 'tomedunn/vim.fortran', { 'for': 'fortran' }

" [HTML coding] --------------------------------------------------------------
    " Generate HTML in a simple way
    Plug 'mattn/emmet-vim', { 'for': 'html' }
    " Generate closetag for HTML
    Plug 'alvan/vim-closetag', { 'for': [ 'html', 'markdown'] }

" [Latex] --------------------------------------------------------------------
    if USING_GUI_SOFTWARE
        " Asynchronous Tex file -> PDF file preview (pdf reader is needed)
        Plug 'xuhdev/vim-latex-live-preview',
                    \ { 'for': [ 'plaintex', 'context', 'tex'] }
    endif
    " Latex compiler link support (complier need to be installed externally)
    Plug 'vim-latex/vim-latex', { 'for': [ 'plaintex', 'context', 'tex'] }

" [Markdown] -----------------------------------------------------------------
    if USING_GUI_SOFTWARE
        if USING_VIM8
            " Synchronous markdown file previewer
            " NOTE: For now, the hook function is not working. You have to
            " enter :call mkdp#util#install() by yourself after plug
            " installation. Make sure you have nodejs and yarn installed
            Plug 'iamcco/markdown-preview.nvim',
                        \ { 'do': { -> mkdp#util#install() },
                        \ 'for': [ 'markdown', 'vim-plug' ] }
        endif
    endif
    " Markdown syntax header folding
    Plug 'masukomi/vim-markdown-folding', { 'for': 'markdown' }
    Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }

" [I3 syntax highlight] ------------------------------------------------------
    " I3 configuration syntax highlight
    Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }

" [BitoAI (ChatGPT wrapper)] -------------------------------------------------
    Plug 'zhenyangze/vim-bitoai'

" [LeetCode] -----------------------------------------------------------------
    "Plug 'ianding1/leetcode.vim'

" End of plugin loading ------------------------------------------------------
    " Tell vim-plug we finished declaring plugins, so it can load them
    call plug#end()

    " NOTE: plugin loading [Now use vim-startuptime plugin instead]
    " -- Check vim startup time and loaded plugins
    " -- vim --startuptime /tmp/startup.log [file_to_test] +q && vim /tmp/startup.log

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

" Tab key settings [Must be added after vim-plug to prevent being overwritten]
    set expandtab      " expand tab to spaces
    set tabstop=4      " number of space that tab in the file counts
    set shiftwidth=4   " number of space of auto-indent length
    set softtabstop=-1 " number of space that tab while editing
                       " negative value -> adopt shiftwidth value
    noremap <leader>et :set expandtab!<CR>

" Filetype-dependent tab key settings ----------------------------------------
    " PEP8 recommendation for tab settings
    autocmd FileType python
                \ setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=-1
    " CPP
    autocmd FileType cpp
                \ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=-1

" ============================================================================
" Part 2 - Vim-theme settings (Plugins settings and mappings)
" ============================================================================
" Vim-theme settings, edit them as you wish.
" As for color scheme, it is in the end of this plug settings section

" Lightline statusline/tabline options ---------------------------------------
    " Lightline style setup
    function! LightlineStyle(theme, fancy, central_region_opaque)

        " Part 1 - Lightline setup -------------------------------------------
        " Initialize g:lightline variable
        let g:lightline = { 'colorscheme': a:theme }
        " Specify g:lightline dictionary objects
        let g:lightline.enable = { 'statusline': 1, 'tabline': 1 }

        " Part 2 - Statusline setup ------------------------------------------
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
        " Statusline component function
        let g:lightline.component_function = { 'gitbranch': 'FugitiveHead', }
        " Fancy symbol for statusline separator
        if a:fancy
            let g:lightline.separator = { 'left': "", "right": "" }
            let g:lightline.subseparator = { 'left': '/', 'right': '/' }
        endif

        " Part 3 - Tabline setup (bufferline plugin) -------------------------
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
        let g:lightline#bufferline#min_buffer_count = 2
        let g:lightline#bufferline#min_tab_count = 2
        let g:lightline#bufferline#unnamed = '[No Name]'
        let g:lightline#bufferline#filter_by_tabpage = 1
        " Fancy character for tabline (bufferline)
        if a:fancy
            let g:lightline#bufferline#enable_devicons = 1
            let g:lightline#bufferline#enable_nerdfont = 1
            let g:lightline#bufferline#unicode_symbols = 1
        endif

        " Part 4 - Miscellaneous setup ---------------------------------------
        " Central bar opaque option
        if !a:central_region_opaque
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
    if USING_CUSTOMIZED_THEME
        " Toggle lightline tabline
        noremap <leader>slte :set showtabline=2<CR>:echo "TABLINE ENABLED"<CR>
        noremap <leader>sltd :set showtabline=0<CR>:echo "TABLINE DISABLED"<CR>
        " Toggle lightline statusline
        noremap <leader>slse :call lightline#enable()<CR>:set noshowmode<CR>
                    \:set laststatus=2<CR>:echo "LIGHTLINE ENABLED"<CR>
        noremap <leader>slsd :call lightline#disable()<CR>:set showmode<CR>
                    \:set laststatus=2<CR>:echo "LIGHTLINE DISABLED"<CR>
        " Toggle all lightline status/tab line
        noremap <leader>slae :call lightline#enable()<CR>:set showmode<CR>
                    \:set showtabline=2<CR>:set laststatus=2<CR>
                    \:echo "STATUSLINE/TABLINE DISABLED"<CR>
        noremap <leader>slad :call lightline#disable()<CR>:set showmode<CR>
                    \:set showtabline=0<CR>:set laststatus=0<CR>
                    \:echo "STATUSLINE/TABLINE DISABLED"<CR>
    endif

" Function - reload lightline ------------------------------------------------
    " -- Reload lightline without closing editing files
    " -- From https://github.com/itchyny/lightline.vim/issues/241
    function! LightlineReload()
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endfunction

" Status/Tab line ------------------------------------------------------------
    set noshowmode    " No vim-built-in mode statusline
    set laststatus=2  " Always display the statusline in all windows
    set showtabline=2 " Always show the tabline, even if there is only one tab
    set cmdheight=1   " Size of command line height
    set showcmd       " This line must be added AFTER statusline option

" Keymapping for bufferline --------------------------------------------------
    " NOTE:
    " -- Here use buffer number in bufferline not buffer number in buffers

    " Goto buffers
    nmap <leader>'1 <Plug>lightline#bufferline#go(1)
    nmap <leader>'2 <Plug>lightline#bufferline#go(2)
    nmap <leader>'3 <Plug>lightline#bufferline#go(3)
    nmap <leader>'4 <Plug>lightline#bufferline#go(4)
    nmap <leader>'5 <Plug>lightline#bufferline#go(5)
    nmap <leader>'6 <Plug>lightline#bufferline#go(6)
    nmap <leader>'7 <Plug>lightline#bufferline#go(7)
    nmap <leader>'8 <Plug>lightline#bufferline#go(8)
    nmap <leader>'9 <Plug>lightline#bufferline#go(9)
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
" File/Code browsing settings, edit them as you wish.

" fzf.vim --------------------------------------------------------------------
    " NOTE:
    " -- ripgrep must be installed if Rg function is needed
    " -- the_silver_searcher must be installed if Ag function is needed
    " -- if focus on fzf floating window is stolen, press <C-w>w severals time
    "    to cycle focus back

    " Fish is not fully compatible for fzf.vim, change to bash for convenience
    let $SHELL = '/bin/bash'
    " Add prefix FZF to all fzf commands
    let g:fzf_command_prefix = 'FZF'
    " Default fzf action keymapping
    let g:fzf_action = {
                \ 'ctrl-t': 'tab split',
                \ 'ctrl-s': 'split',
                \ 'ctrl-v': 'vsplit' }
    " fzf window layout
    let g:fzf_layout = { 'window': '-tabnew' }
    " Preview window layout
    let g:fzf_preview_window = ['right:50%,<70(up:50%)', 'alt-/']
    nnoremap <leader>fpl :let g:fzf_preview_window = ['right:50%', 'alt-/']<CR>
    nnoremap <leader>fpj :let g:fzf_preview_window = ['down:50%', 'alt-/']<CR>
    nnoremap <leader>fpk :let g:fzf_preview_window = ['up:50%', 'alt-/']<CR>
    nnoremap <leader>fph :let g:fzf_preview_window = ['left:50%', 'alt-/']<CR>
    " Line in local/global buffer
    nnoremap <leader>fbl :FZFBLines<CR>
    nnoremap <leader>fbL :execute ":FZFBLines " . expand('<cword>')<CR>
    nnoremap <leader>fgl :FZFLines<CR>
    nnoremap <leader>fgL :execute ":FZFLines " . expand('<cword>')<CR>
    nnoremap <leader>?   :execute ":FZFLines " . expand('<cword>')<CR>
    " Tag in local/global buffer
    nnoremap <leader>fbt :FZFBTags<CR>
    nnoremap <leader>fbT :execute ":FZFBTag " . expand('<cword>')<CR>
    nnoremap <leader>fgt :FZFTags<CR>
    nnoremap <leader>fgT :execute ":FZFTag " . expand('<cword>')<CR>
    " File/Pattern search
    nnoremap <leader>ffs :FZFFiles<CR>
    nnoremap <leader>ffS :FZFFiles<space>
    nnoremap <leader>flc :FZFLocate<space>
    nnoremap <leader>fag :FZFAg<CR>
    nnoremap <leader>frg :FZFRg<CR>
    nnoremap <leader>frG :FZFRG<CR>
    " Git command (requires fugitive.vim plugin)
    nnoremap <leader>fgf :FZFGFiles<CR>
    nnoremap <leader>fgs :FZFGFiles?<CR>
    nnoremap <leader>fgc :FZFBCommits<CR>
    nnoremap <leader>fgC :FZFCommits<CR>
    " History
    nnoremap <leader>fhs :FZFHistory<CR>
    nnoremap <leader>fh: :FZFHistory:<CR>
    nnoremap <leader>fh/ :FZFHistory/<CR>
    " Buffers/Windows
    nnoremap <leader>fbs :FZFBuffers<CR>
    nnoremap <leader>fws :FZFWindows<CR>
    " Marks
    nnoremap <leader>fmk :FZFMarks<CR>
    nnoremap <leader>f'  :FZFMarks<CR>
    " Miscellaneous
    nnoremap <leader>qO  :FZFQuickFix<CR>
    nnoremap <leader>eO  :FZFLocList<CR>
    nnoremap <leader>fcd :FZFCommands<CR>
    nnoremap <leader>fmp :FZFMaps<CR>
    nnoremap <leader>fft :FZFFiletypes<CR>
    nnoremap <leader>fht :FZFHelptags<CR>
    " Add patch for jump/change list
    exec 'source ' . s:FZF_PATCH
    nnoremap <leader>fcl :FZFChanges<CR>
    nnoremap <leader>fjl :FZFJumps<CR>
    " FZF replacement
    nnoremap <leader>'  :FZFBuffers<CR>
    nnoremap <leader>mk :FZFMarks<CR>
    nnoremap <leader>g; :FZFChanges<CR>
    nnoremap <leader>g. :FZFChanges<CR>
    nnoremap <leader>gi :FZFJumps<CR>
    nnoremap <leader>go :FZFJumps<CR>
    nnoremap <leader>rg :FZFRg<CR>
    nnoremap <leader>rG :FZFRG<CR>

" NERDTree -------------------------------------------------------------------
    " NERDTree Pane
    let g:NERDTreeWinPos = 'left'
    let g:NERDTreeWinSize = 40
    let g:NERDTreeShowLineNumbers = 0
    let g:NERDTreeShowHidden = 0
    " Disable bookmark label in nerdtree
    let g:NERDTreeMinimalUI = 0
    " Don;t show these file types
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
    let g:NERDTreeMouseMode = 3
    let g:NERDTreeDirArrows = ''
    " Set NERDTree dir arrow symbols
    let g:NERDTreeDirArrowExpandable = '►'
    let g:NERDTreeDirArrowCollapsible = '▼'
    " Set NERDTree open split
    let g:NERDTreeMapOpenSplit = 's'
    let g:NERDTreeMapOpenVSplit = 'v'
    " Set NERDTree open preview
    let g:NERDTreeletPreviewSplit = 'gs'
    let g:NERDTreeletPreviewVSplit = 'gv'
    " Toggle NERDTree Zoom
    let g:NERDTreeMapToggleZoom = 'zz'
    " Toggle NERDTree display pane
    noremap <F3> :silent! NERDTreeToggle<CR>
    " Open NERDTree with the current file selected
    noremap <leader><F3> :silent! NERDTreeFind<CR>
    " Tagbar location
    noremap <leader>ntl :let g:NERDTreeWinPos = 'left'<CR>
    noremap <leader>ntr :let g:NERDTreeWinPos = 'right'<CR>

" Mundo ----------------------------------------------------------------------
    " Toggle undotree
    noremap <leader>ut :MundoToggle<CR>

" Tagbar ---------------------------------------------------------------------
    " Tagbar pane
    let g:tagbar_position = 'botright vertical'
    let g:tagbar_width = 40
    " Autofocus on tagbar open
    let g:tagbar_autofocus = 1
    " Disable sort in tagbar
    let g:tagbar_sort = 0
    " Map tagbar shortcut same as vim fold
    let g:tagbar_map_closeallfolds = 'zM'
    let g:tagbar_map_openallfolds = 'zR'
    let g:tagbar_map_closefold = 'zc'
    let g:tagbar_map_openfold = 'zo'
    " tagbar zoom
    let g:tagbar_map_zoomwin = 'zz'
    let g:tagbar_map_showproto = 'd'
    " Toggle tagbar display
    noremap <F4> :TagbarToggle<CR>
    " Tagbar location
    noremap <leader>tgl :let g:tagbar_position = 'leftabove vertical'<CR>
    noremap <leader>tgr :let g:tagbar_position = 'botright vertical'<CR>

" ============================================================================
" Part 4 - Vim useful functions settings (Plugins settings and mappings)
" ============================================================================
" Vim useful functions settings, edit them as you wish.

" Vim-man --------------------------------------------------------------------
    " NOTE:
    " -- K (Vim help page for current selected word)

    " Open offline manual in system
    noremap <leader>mm :Man<space>
    noremap <leader>mM :execute ":Man " . expand('<cword>')<CR>

" LargeFile ------------------------------------------------------------------
    " Large file size in MB
    let g:LargeFile = 10

" Nerdcommenter --------------------------------------------------------------
    " NOTE:
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
    map <leader>cy <Plug>NERDCommenterYank
    " Block comment for common editor convention
    " NOTE: Ctrl+/ is recognized as Ctrl+_ by vim in linux
    map <C-_> <Plug>NERDCommenterToggle
    map <C-/> <Plug>NERDCommenterToggle

" Vim-surround ---------------------------------------------------------------
    " Surround current word or sentence with brackets or HTML tags
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
    nnoremap <leader>z :MaximizerToggle<CR>
    vnoremap <leader>z :MaximizerToggle<CR>gv
    nnoremap <C-w>z :MaximizerToggle<CR>
    vnoremap <C-w>z :MaximizerToggle<CR>gv

" Window-chooser (choosewin)--------------------------------------------------
    " Show big overlay letters
    let g:choosewin_overlay_enable = 1
    nmap <leader>" <Plug>(choosewin)

" Auto-pairs -----------------------------------------------------------------
    " Insert, visual, normal mode
    let g:AutoPairsShortcutToggle = "<M-'>"
    let g:AutoPairsShortcutJump = '<M-;>'
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

" Vim-current-word -----------------------------------------------------------
    " Disable highlight current word and twin words at start
    let g:vim_current_word#enabled = 0
    map <leader>cw :VimCurrentWordToggle<CR>

" Vim-Tmux-navigator ---------------------------------------------------------
    " Disable navigator when TMUX pane is zoomed
    let g:tmux_navigator_disable_when_zoomed = 1
    " Disable default keymappings
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent><C-h> :TmuxNavigateLeft<CR>
    nnoremap <silent><C-j> :TmuxNavigateDown<CR>
    nnoremap <silent><C-k> :TmuxNavigateUp<CR>
    nnoremap <silent><C-l> :TmuxNavigateRight<CR>

" ============================================================================
" Part 5 - Vim extra functions settings (Plugins settings and mappings)
" ============================================================================
" Vim extra functions settings, edit them as you wish.

" Vimwiki --------------------------------------------------------------------
    if USING_EXTRA_PLUG
        " Disable all local mappings then remap needed ones
        let g:vimwiki_key_mappings = { 'all_maps': 0, }
        " Vimwiki Settings
        let g:vimwiki_list = [
        \ {'path': '~/Documents/KNOWLEDGE_BASE/', 'syntax': 'markdown', 'ext': '.md'},
        \ ]
        " Must set to expr to get vim-markdown-folding to work
        let g:vimwiki_folding='expr'
        " Set all markdown filetype to vimwiki
        let g:vimwiki_global_ext = 1
        " Create tagbar type for vimwiki
        let g:tagbar_type_vimwiki = {
                    \ 'ctagstype':'vimwiki',
                    \ 'kinds':['h:header'],
                    \ 'sro':'&&&' ,
                    \ 'kind2scope':{'h':'header'},
                    \ 'sort':0,
                    \ 'ctagsbin': s:CTAGSBIN,
                    \ 'ctagsargs': 'markdown'
                    \ }
        " Global wiki mappings (start with v)
        nmap <leader>wI <Plug>VimwikiIndex
        nmap <leader>wD <Plug>VimwikiDeleteFile
        nmap <leader>wR <Plug>VimwikiRenameFile
        nmap <leader>ws <Plug>VimwikiUISelect
        nmap <leader>wT <Esc>:VimwikiTOC<CR>
        nmap <leader><CR> <Plug>VimwikiFollowLink
        nmap <leader><Backspace> <Plug>VimwikiGoBackLink
        " Goto markdown file (create one if there is no one)
        nmap <leader>w<CR> <Plug>VimwikiGoto
        " Create table
        nmap <leader>wtt <Esc>:VimwikiTable<CR>
        nmap <leader>wth <Esc>:VimwikiTableMoveColumnLeft<CR>
        nmap <leader>wtl <Esc>:VimwikiTableMoveColumnRight<CR>
        " Add HTML tag that assigns text background color
        nmap <leader>wc <Esc>:VimwikiColorize<CR>
        " Diary mappings (start with v and then d)
        nmap <leader>wdG <Plug>VimwikiDiaryGenerateLinks
        nmap <leader>wdI <Plug>VimwikiDiaryIndex
        nmap <leader>wdd <Plug>VimwikiMakeDiaryNote
        nmap <leader>wdn <Esc>:VimwikiDiaryNextDay<CR>
        nmap <leader>wdp <Esc>:VimwikiDiaryPrevDay<CR>
        nmap <C-Up>      <Esc>:VimwikiDiaryPrevDay<CR>
        nmap <C-Down>    <Esc>:VimwikiDiaryNextDay<CR>
    endif

" Goyo -----------------------------------------------------------------------
    if USING_EXTRA_PLUG
        noremap <leader>gy :Goyo<CR>
    endif

" Limelight ------------------------------------------------------------------
    if USING_EXTRA_PLUG
        " Color name (:help cterm-colors) or ANSI code
        let g:limelight_conceal_ctermfg = 'gray'
        let g:limelight_conceal_ctermfg = 240
        " Color name (:help gui-colors) or RGB color
        let g:limelight_conceal_guifg = 'DarkGray'
        let g:limelight_conceal_guifg = '#777777'
        let g:limelight_default_coefficient = 0.7
        " Number of preceding/following paragraphs to include (default: 0)
        let g:limelight_paragraph_span = 1
        " Beginning/end of paragraph
        "   When there's no empty line between the paragraphs
        "   and each paragraph starts with indentation
        let g:limelight_bop = '^\s'
        let g:limelight_eop = '\ze\n^\s'
        " Highlighting priority (default: 10)
        "   Set it to -1 not to overrule hlsearch
        let g:limelight_priority = -1
        " Integration with goyo
        autocmd! User GoyoEnter Limelight
        autocmd! User GoyoLeave Limelight!
    endif

" YankRing -------------------------------------------------------------------
    if USING_EXTRA_PLUG
        if USING_NEOVIM
            let g:yankring_history_dir = '~/.config/nvim/'
            " Fix for yankring and neovim problem when system has non-text
            " things copied in clipboard
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
        noremap <leader>yp :set paste!<CR>
    endif

" Peekaboo -------------------------------------------------------------------
    " Remap '"', '@' (Normal mode) and '<C-r>' (Insert mode) for register viewer
    if USING_EXTRA_PLUG
        let g:peekaboo_window = 'vert bo 40new'
        let g:peekaboo_prefix = ''
        let g:peekaboo_compat = 1
    endif

" Markbar --------------------------------------------------------------------
    " Remap ''', '`' (Normal mode) for mark viewer
    if USING_EXTRA_PLUG
        " width of a vertical split markbar
        let g:markbar_width = 40
        let g:markbar_peekaboo_width = 40
        " Ditto, but more granularly (any may be omitted)
        let g:markbar_num_lines_context = {
            \ 'peekaboo_around_local': 3,
            \ 'peekaboo_around_file': 1,
        \ }
        " Leave peekaboo markbar enabled, but don't set default mappings
        let g:markbar_set_default_peekaboo_mappings = v:false
        " Markbar format
        let g:markbar_file_mark_format_string = '%s (%d, %d)'
        let g:markbar_file_mark_arguments = ['fname', 'col', 'line']
        " Peekaboo-like markbar (remap vim built-in ' key)
        nmap ` <Plug>OpenMarkbarPeekabooApostrophe
        " Peekaboo-like markbar (remap vim built-in ` key)
        nmap ' <Plug>OpenMarkbarPeekabooBacktick
    endif

" Easymotion -----------------------------------------------------------------
    if USING_EXTRA_PLUG
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
        nmap <leader>/ <Plug>(easymotion-sn)
    endif

" AutoComplPop ---------------------------------------------------------------
    if USING_EXTRA_PLUG
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
        if USING_PYTHON_COMPLETION
            autocmd FileType python let g:acp_enableAtStartup = 0
        endif
    endif

" Pop-up window selection ----------------------------------------------------
    " AUto completion pop-up, use Ctrl+[e/y] to close/select completion

    " [Double quotation matters here, DO NOT change to single quotation]
    if USING_EXTRA_PLUG
        inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
        inoremap <expr><tab>   pumvisible() ? "\<C-n>" : "\<tab>"
        inoremap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
        inoremap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
        inoremap <expr><M-k>   pumvisible() ? "\<C-p>" : "\<M-k>"
        inoremap <expr><M-j>   pumvisible() ? "\<C-n>" : "\<M-j>"
        inoremap <expr><C-b>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-b>"
        inoremap <expr><C-f>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-f>"
    endif

" Tasklist -------------------------------------------------------------------
    if USING_EXTRA_PLUG
        noremap <leader>tl :TaskList<CR>
    endif

" Hexokinase -----------------------------------------------------------------
    " -- For compling, golang must be installed [sudo dnf install golang]
    if USING_EXTRA_PLUG
        " All possible values for hexokinase pattern
        let g:Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'
        " Set highlighter for hexokinase
        let g:Hexokinase_highlighters = [ 'backgroundfull' ]
        noremap <leader>chk :HexokinaseToggle<CR>
    endif

" ============================================================================
" Part 6 - Vim coding tools settings (Plugins settings and mappings)
" ============================================================================
" Vim coding tools settings, edit them as you wish.

" ALE (Asynchronous Lint Engine) ---------------------------------------------
    " -- For python, flake8, pylint or other linting engines must be installed
    "    -- pip install mypy   # type checker
    "    -- pip install flake8 # error and style linter
    "    -- pip install pylint # error and style linter
    if USING_CODING_TOOL_PLUG && !USING_LSP
        if USING_NEOVIM
            let g:ale_use_neovim_diagnostics_api = 1
        endif
        let g:ale_enabled = 0
        let g:ale_disable_lsp = 1
        let g:ale_linters = { 'python': ['mypy', 'isort', 'yapf', 'flake8'] }
        " ALE use location list for output, instead of quickfix list
        let g:ale_set_loclist = 1
        let g:ale_set_quickfix = 0
        noremap <leader>ee :ALEToggle<CR>
        noremap <leader>ei :ALEInfo<CR>
    endif

" Neoformat ------------------------------------------------------------------
    if USING_CODING_TOOL_PLUG
        " C++ ----------------------------------------------------------------
        " clangformat: C++ formatter
        nnoremap <leader>cf :Neoformat clangformat<CR>
        " Python -------------------------------------------------------------
        " pyment: python docstring creater/formatter
        let g:neoformat_python_pyment_google = {
                \ 'exe': 'pyment',
                \ 'args': ['-', '-o "google"', '-w'],
                \ 'stdin': 1,
                \ }
        let g:neoformat_python_pyment_javadoc = {
                \ 'exe': 'pyment',
                \ 'args': ['-', '-o "javadoc"', '-w'],
                \ 'stdin': 1,
                \ }
        let g:neoformat_python_pyment_numpydoc = {
                \ 'exe': 'pyment',
                \ 'args': ['-', '-o "numpydoc"', '-w'],
                \ 'stdin': 1,
                \ }
        let g:neoformat_enabled_python = ['pyment_google', 'pyment_javadoc']
        " pyment: python docstring creater/formatter
        nnoremap <leader>ptd :Neoformat pyment<CR>
        nnoremap <leader>ptg :Neoformat pyment_google<CR>
        nnoremap <leader>ptj :Neoformat pyment_javadoc<CR>
        nnoremap <leader>ptn :Neoformat pyment_numpydoc<CR>
        " pyment: visual mode selection for finetune
        vnoremap <leader>ptd :'<,'>Neoformat pyment<CR>
        vnoremap <leader>ptg :'<,'>Neoformat pyment_google<CR>
        vnoremap <leader>ptj :'<,'>Neoformat pyment_javadoc<CR>
        vnoremap <leader>ptn :'<,'>Neoformat pyment_numpydoc<CR>
        " isort: python import sorter
        nnoremap <leader>pi :Neoformat isort<CR>
        " yapf: python code formatter
        nnoremap <leader>py :Neoformat yapf<CR>
    endif

" Rainbow parentheses --------------------------------------------------------
    if USING_CODING_TOOL_PLUG
        " Don;t enable when start up
        let g:rainbow_active = 0
        noremap <leader>rw :RainbowToggle<CR>
    endif

" Indentline -----------------------------------------------------------------
    if USING_CODING_TOOL_PLUG
        let g:indentLine_showFirstIndentLevel = 1
        let g:indentLine_fileTypeExclude = ['text', 'markdown', 'latex']
        let g:indentLine_bufTypeExclude = ['help', 'terminal']
        noremap <F9> :IndentLinesToggle<CR>
    endif

" Indent guides --------------------------------------------------------------
    if USING_CODING_TOOL_PLUG
        let g:indent_guides_enable_on_vim_startup = 0
        let g:indent_guides_start_level = 1
        let g:indent_guides_guide_size = 4
        let g:indent_guides_auto_colors = 0
        autocmd VimEnter,Colorscheme *
                    \ :highlight IndentGuidesOdd  guibg='#303030' ctermbg=7
        autocmd VimEnter,Colorscheme *
                    \ :highlight IndentGuidesEven guibg='#24242d' ctermbg=8
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
    if USING_CODING_TOOL_PLUG
        let g:VM_default_mappings = 0
        let g:VM_leader = '<space>'
        let g:VM_maps = {}
        let g:VM_maps['Find Under'] = '<M-n>'
        let g:VM_maps["Add Cursor Down"] = '<M-S-j>'
        let g:VM_maps["Add Cursor Up"] = '<M-S-k>'
        let g:VM_maps["Select All"] = '<M-a>'
        let g:VM_maps["Find Next"] = ']'
        let g:VM_maps["Find Prev"] = '['
        let g:VM_maps["Skip Region"] = 'q'
        let g:VM_maps["Remove Region"] = 'Q'
    endif

" Vim-fugitive ---------------------------------------------------------------
    " -- :G Summary for current git repository
    if USING_CODING_TOOL_PLUG
        noremap <leader>gd :Git diff %<CR>
        noremap <leader>gD :Git diff<CR>
        noremap <leader>gs :Git<CR>
        noremap <leader>gc :Gclog<CR>
        noremap <leader>gl :Gllog<CR>
        noremap <leader>gA :Git add %<CR>
        noremap <leader>gC :Git commit<CR>
        noremap <leader>gR :Git reset<space>
        noremap <leader>gB :Git blame<CR>
    endif

" GitGutter ------------------------------------------------------------------
    if USING_CODING_TOOL_PLUG
        " Disable all gitgutter key mappings
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
        highlight GitGutterAdd    cterm=bold ctermfg=10 ctermbg=NONE gui=bold guifg=#009900 guibg=NONE
        highlight GitGutterChange cterm=bold ctermfg=11 ctermbg=NONE gui=bold guifg=#bbbb00 guibg=NONE
        highlight GitGutterDelete cterm=bold ctermfg=9  ctermbg=NONE gui=bold guifg=#ff2222 guibg=NONE
        " GitGutter toggle
        noremap <leader>gg :GitGutterToggle<CR>
        noremap <leader>gb :GitGutterBufferToggle<CR>
        " GitGutter highlight toggle
        noremap <leader>ghs :GitGutterSignsToggle<CR>
        noremap <leader>ghl :GitGutterLineHighlightsToggle<CR>
        noremap <leader>ghn :GitGutterLineNrHighlightsToggle<CR>
        noremap <leader>ghe :GitGutterEnable<CR>:GitGutterSignsEnable<CR>
                    \:GitGutterLineHighlightsEnable<CR>
        noremap <leader>ghd :GitGutterEnable<CR>:GitGutterDisable<CR>
                    \:GitGutterSignsDisable<CR>:GitGutterLineHighlightsDisable<CR>
        " GitGutter hunk: diff preview
        nmap <leader>gq :GitGutterQuickFix<CR>
        nmap <leader>gP <Plug>(GitGutterPreviewHunk)
        nmap <leader>gF :GitGutterFold<CR>
        " GitGutter action: add/restore
        nmap <leader>ga <Plug>(GitGutterStageHunk)
        nmap <leader>gr <Plug>(GitGutterUndoHunk)
        " Move through hunks in current buffer
        nmap <leader>gj <Plug>(GitGutterNextHunk)zz
        nmap <leader>gk <Plug>(GitGutterPrevHunk)zz
    endif

" Vim-Unimpaired -------------------------------------------------------------
    " -- [: previous, ]:next
    " -- a:arg, b:buffer, l:locationlist, q:quickfix
    if USING_CODING_TOOL_PLUG
        nmap [e [l
        nmap ]e ]l
        nmap [E [L
        nmap ]E ]L
    endif

" ============================================================================
" Part 7 - Python coding tools settings (Plugins settings and mappings)
" ============================================================================
" Python coding tools settings, edit them as you wish.

" Deoplete -------------------------------------------------------------------
    " Front end for python completion
    " Pynvim is needed [Installation: pip3 install --user pynvim]
    if USING_PYTHON_COMPLETION && !USING_LSP
        " Needed so deoplete can auto select the first suggestion
        set completeopt+=noinsert
        " Comment this line to enable autocompletion preview window
        " (displays documentation related to the selected completion option)
        " Disabled by default because preview makes the window flicker
        set completeopt-=preview
        " Enable deoplete at startup
        let g:deoplete#enable_at_startup = 1
        " Python that uses to install jedi
        let g:python3_host_prog = s:PYTHON_FOR_COMPLETION
        " Maximum length for completion
        let g:deoplete#sources#jedi#statement_length = 30
        " Ignore case for deoplete
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
    " jedi is needed [Installation: pip3 install --user jedi]
    " jedi-vim remaps K to open python documents
    if USING_PYTHON_COMPLETION && !USING_LSP
        " Disable autocompletion (using deoplete instead)
        let g:jedi#completions_enabled = 0
        " Use split instead of buffer
        let g:jedi#use_splits_not_buffers = "bottom"
        " Open variable definition/docstring
        let g:jedi#goto_command = '<leader>pg'
        let g:jedi#goto_definitions_command = "<leader>pd"
        " Find all usages of variable name
        let g:jedi#usages_command = '<leader>pn'
        " Rename variable name
        let g:jedi#rename_command = '<leader>pr'
        " Goto stubs
        let g:jedi#goto_stubs_command = '<leader>ps'
        " Find variable assignments (Goto function)
        let g:jedi#goto_assignments_command = '<leader>pa'
        " Open python module [show __init__.py]
        autocmd FileType python noremap <leader>pM :Pyimport<space>
        autocmd FileType python
                    \ noremap <leader>pm
                    \ :execute ":Pyimport " . expand('<cword>')<CR>
    endif

" Python debug (add python breakpoints) --------------------------------------
    "" Python built-in pdb debugge (python > 3.7 ONLY)
    "autocmd FileType python
                "\ noremap <leader>pb Obreakpoint()<Esc>
    " Python built-in pdb debugger
    autocmd FileType python
                \ noremap <leader>pb Oimport pdb; pdb.set_trace()<Esc>
    " %:p for current file in full path
    autocmd FileType python
                \ noremap <leader>pB
                \ <Esc>:split<CR>:terminal python -m pdb '%:p'<space>

" Python skeleton (add python skeleton for new python .py file) --------------
    if USING_PYTHON_SKELETON
        exec 'autocmd BufNewFile *.py 0r' s:PYTHON_SKELETON
    endif

" ============================================================================
" Part 8 - Other language coding tools settings (Plugin settings and mappings)
" ============================================================================
" Other language support settings, edit them as you wish.
" Language support: Fortran, LaTex, HTML, Markdown

" Fortran --------------------------------------------------------------------
    " Ensure correct highlighting for
    " Fortran free-form source code and turn syntax highlighting on
    let fortran_free_source = 1
    let fortran_do_enddo = 1

" LaTex ----------------------------------------------------------------------
    " Set spell check for LaTex files
    autocmd FileType plaintex,context,tex setlocal spell
    autocmd FileType plaintex,context,tex setlocal updatetime=10000 " Unit: ms
    " Latex real-time viewer with GUI pdf file manager
    if USING_GUI_SOFTWARE
        let g:livepreview_previewer = 'zathura'
        let g:livepreview_engine = 'pdflatex'
        autocmd BufEnter *.tex echom '[Press Space+F4 to Preview .tex File]'
        autocmd BufEnter *.tex noremap <leader><F4> :LLPStartPreview<CR>
    endif
    " Load template file when new file created
    if USING_TEX_TEMPLATE
        exec 'autocmd BufNewFile *.tex 0r' s:TEX_TEMPLATE
    endif

" Markdown -------------------------------------------------------------------
    " Set spell check for markdown files
    autocmd FileType markdown setlocal spell
    " Markdown previewer [no extra vim plugin needed]
    " From https://krehwell.com/blog/Open%20Markdown%20Previewer%20Through%20Vim
    " Google-chrome extension is needed for markdown viewer
    if USING_GUI_SOFTWARE && !USING_VIM8
        let $OPENBROWSER = 'noremap <leader><F4> :!'. s:WEBBROWSER .' %:p &<CR>'
        autocmd BufEnter *.md echom '[Press Space+F4 to Preview .md File]'
        autocmd BufEnter *.md exe $OPENBROWSER
    endif
    " Synchronous markdown previewer (markdown-preview plugin)
    if USING_GUI_SOFTWARE && USING_VIM8
        " Web browser used to preview
        let g:mkdp_browser = s:WEBBROWSER
        " Close browser after markdown file is close
        let g:mkdp_auto_close = 0
        " Show url of markdown previewer
        let g:mkdp_echo_preview_url = 1
        autocmd BufEnter *.md echom '[Press Space+F4 to Preview .md File]'
        autocmd BufEnter *.md nmap <leader><F4> <Plug>MarkdownPreviewToggle<CR>
        autocmd BufEnter *.md setlocal scrolloff=999
    endif
    " MARP: markdown presentation ecosystem (https://marp.app/)
    noremap <leader>mp <Esc>:!marp % --html<CR>
    let $OPENHTMLBROWSER = 'noremap <leader>mP :!'. s:WEBBROWSER .' %:r.html &<CR>'
    autocmd BufEnter *.md exe $OPENHTMLBROWSER
    " Load template file when new file created
    if USING_MARKDOWN_TEMPLATE
        exec 'autocmd BufNewFile *.md 0r' g:MARKDOWN_TEMPLATE
    endif
    " Insert image
    noremap <leader>mi <Esc>i![this_is_an_image]()<Left>
    noremap <leader>mI <Esc>i<img src="" width="100%" height="100%"/><Esc>29<Left>
    " Insert video in markdown file
    noremap <leader>mV <Esc>i<video src="" width="100%" height="100%" control/><Esc>37<Left>
    " Insert link
    noremap <leader>ml <Esc>i[this_is_a_link]()<Left>
    " Insert code block
    noremap <leader>mb <Esc>i```<CR>```<Up>
    " Insert HTML style color tag
    noremap <leader>mc <Esc>i<span style="color:"><Esc>F<<Esc>19<Right>i
    noremap <leader>mC <Esc>a</span><Esc>
    " Insert HTML table template
    noremap <leader>mT <Esc>:execute('r'.g:MARKDOWN_TABLE_TEMPLATE)<CR>

" BitoAI ---------------------------------------------------------------------
    noremap <leader>aic :BitoAiCheck<CR>
    noremap <leader>aip :BitoAiCheckPerformance<CR>
    noremap <leader>ais :BitoAiCheckStyle<CR>
    noremap <leader>aiS :BitoAiCheckSecurity<CR>
    noremap <leader>aie :BitoAiExplain<CR>
    noremap <leader>aig :BitoAiGenerate<CR>
    "noremap <leader>aiG :BitoAiGenerateComment<CR>
    noremap <leader>air :BitoAiReadable<CR>

" LeetCode -------------------------------------------------------------------
    "let g:leetcode_browser = 'firefox'
    "let g:leetcode_hide_paid_only = 1
    "let g:leetcode_solution_filetype = 'python'

" ============================================================================
" Part 10 - Language Server Protocol (LSP)
" ============================================================================

" Vim-LSP --------------------------------------------------------------------
    if USING_LSP && USING_VIM8
        " Show LSP server status
        nmap <buffer> <leader>LS :LspStatus<CR>
        " Manage LSP server
        nmap <buffer> <leader>LM :LspManageServers<CR>
        nmap <buffer> <leader>LI :LspInstallServer<CR>
        " Stop LSP server
        nmap <buffer> <leader>Ls :LspStopServer<CR>
        " Restart LSP server
        noremap <buffer> <leader>Lr
            \ :lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>
            \ :edit<CR>
        " Load LSP diagnostics to location list
        nmap <buffer> <leader>ee :LspDocumentDiagnostics<CR>
        " Load LSP
        function! s:on_lsp_buffer_enabled() abort
            " LSP settings
            setlocal omnifunc=lsp#complete
            setlocal signcolumn=yes
            if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
            " LSP keybinding
            nmap <buffer> gd <plug>(lsp-definition)
            nmap <buffer> g/ <plug>(lsp-document-symbol-search)
            nmap <buffer> g? <plug>(lsp-workspace-symbol-search)
            nmap <buffer> gr <plug>(lsp-references)
            nmap <buffer> gi <plug>(lsp-implementation)
            nmap <buffer> gy <plug>(lsp-type-definition)
            nmap <buffer> <leader>rn <plug>(lsp-rename)
            nmap <buffer> [g <plug>(lsp-previous-diagnostic)
            nmap <buffer> ]g <plug>(lsp-next-diagnostic)
            nmap <buffer> K <plug>(lsp-hover)
            " Close pop-up window without opening a new line
            inoremap <expr> <CR>
                        \ pumvisible() ? asyncomplete#close_popup() : "\<CR>"
        endfunction
        " Load LSP
        augroup lsp_install
            au!
            " call s:on_lsp_buffer_enabled only for languages that has the server registered.
            autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
        augroup END
    endif

" ============================================================================
" Part 9 - Colorscheme and other color settings (Plugin settings and mappings)
" ============================================================================
" Set colorscheme (syntax highlight), color assignment, and etc.

" Vim highlight --------------------------------------------------------------
    " Customized color palette
    function! CustomizedColorPalette()
        " Common background setting (dark background)
        set bg=dark
        " Color setup (highlight command must be added after colorscheme)
        highlight Comment       cterm=italic ctermfg=8    ctermbg=NONE gui=italic guifg=#8a8a8a guibg=NONE
        highlight CursorColumn  cterm=NONE   ctermfg=NONE ctermbg=234  gui=NONE   guifg=NONE    guibg=#444444
        highlight CursorLine    cterm=NONE   ctermfg=NONE ctermbg=234  gui=NONE   guifg=NONE    guibg=#444444
        highlight CursorLineNr  cterm=bold   ctermfg=10   ctermbg=NONE gui=bold                 guibg=NONE
        highlight FoldColumn    cterm=NONE   ctermfg=NONE ctermbg=NONE gui=NONE   guifg=NONE    guibg=NONE
        highlight LineNr        cterm=bold   ctermfg=8    ctermbg=NONE gui=bold   guifg=#808080 guibg=NONE
        highlight OverLength    cterm=bold   ctermfg=15   ctermbg=9    gui=bold   guifg=#ffffff guibg=#ff0000
        highlight Pmenu         cterm=bold   ctermfg=8    ctermbg=NONE gui=bold   guifg=#808080 guibg=NONE
        highlight SignColumn    cterm=NONE   ctermfg=NONE ctermbg=NONE gui=NONE   guifg=NONE    guibg=NONE
        highlight UnlimitLength cterm=NONE   ctermfg=NONE ctermbg=NONE gui=NONE   guifg=NONE    guibg=NONE
    endfunction

" Vim colorscheme ------------------------------------------------------------
    " Customized colorscheme settings
    if USING_CUSTOMIZED_THEME
        if USING_WAL_THEME
            " Option 1 - Direct read Xcolor from wal
            "source $HOME/.cache/wal/colors-wal.vim
            " Option 2 - Use wal vim plugin [Recommended]
            colorscheme wal
            " Startup lightline style
            call LightlineStyle('wal', 1, 1)
        else
            " For now, my sway environment has been customized to dracula theme
            if $DESKTOP_SESSION == "sway"
                " Startup color theme
                colorscheme dracula
                " Startup lightline style
                call LightlineStyle('dracula', USING_FANCY_SYMBOLS, 1)
            else
                " Startup color theme
                colorscheme gruvbox
                " Startup lightline style
                call LightlineStyle('gruvbox', USING_FANCY_SYMBOLS, 1)
            endif
        endif
        " Call customized color palette
        call CustomizedColorPalette()
        " Comment below Normal for non-transparent background
        highlight Normal
                    \ cterm=NONE ctermfg=NONE ctermbg=NONE
                    \ gui=NONE guifg=NONE guibg=NONE
    endif
    " Colorscheme shortcut
    nnoremap <leader>csD :colorscheme default<CR>:set termguicolors<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineStyle('default', USING_FANCY_SYMBOLS, 0)<CR>
                \:call LightlineReload()<CR>:echo 'default colorscheme'<CR>
    nnoremap <leader>csg :colorscheme gruvbox<CR>:set termguicolors<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineStyle('gruvbox', USING_FANCY_SYMBOLS, 1)<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineReload()<CR>:echo 'gruvbox colorscheme'<CR>
    nnoremap <leader>csv :colorscheme vim-monokai-tasty<CR>:set termguicolors<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineStyle('deus', USING_FANCY_SYMBOLS, 0)<CR>
                \:call LightlineReload()<CR>:echo 'monokai colorscheme'<CR>
    nnoremap <leader>css :colorscheme srcery<CR>:set termguicolors<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineStyle('srcery_drk', USING_FANCY_SYMBOLS, 1)<CR>
                \:call LightlineReload()<CR>:echo 'srcery colorscheme'<CR>
    nnoremap <leader>csn :colorscheme nord<CR>:set termguicolors<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineStyle('nord', USING_FANCY_SYMBOLS, 1)<CR>
                \:call LightlineReload()<CR>:echo 'nord colorscheme'<CR>
    nnoremap <leader>csd :colorscheme dracula<CR>:set termguicolors<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineStyle('dracula', USING_FANCY_SYMBOLS, 1)<CR>
                \:call LightlineReload()<CR>:echo 'dracula colorscheme'<CR>
    nnoremap <leader>csw :colorscheme wal<CR>:set notermguicolors<CR>
                \:call CustomizedColorPalette()<CR>
                \:call LightlineStyle('wal', 1, 1)<CR>
                \:call LightlineReload()<CR>:echo 'wal colorscheme'<CR>
    " Transparent background shortcut
    nnoremap <leader>cst :highlight Normal cterm=NONE ctermfg=NONE ctermbg=NONE
                \ gui=NONE guifg=NONE guibg=NONE<CR>
                \:echo 'transparent background'<CR><CR>

" ============================================================================
" End of Vim configuration, automatically reload current config after saving
" ============================================================================
    " Automated run vim configuration file just after saving
    "autocmd BufWritePost $MYVIMRC source $MYVIMRC
