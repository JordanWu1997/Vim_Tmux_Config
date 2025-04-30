" ~/.mini_ALE.vim
" vim: ft=vim
" ============================================================================
" My minimal cross-platfrom vim config for normal usage and python coding
" ============================================================================

" ALE installation
if has('win32')
    " Windows: mkdir $HOME\vimfiles\pack\git-plugins\start; git clone --depth 1 https://github.com/dense-analysis/ale.git $HOME\vimfiles\pack\git-plugins\start\ale
    let home = expand('$HOME')
    let vim_plug_path = home . '\vimfiles\pack\git-plugins\start\ale\autoload\ale.vim'
    if !filereadable(vim_plug_path)
        echo 'Installing ALE ...'
        echo ''
        silent execute '!mkdir "' . home . '\vimfiles\pack\git-plugins\start\ale"'
        silent execute '!git clone --depth 1 https://github.com/dense-analysis/ale.git' '"' . home . '\vimfiles\pack\git-plugins\start\ale"'
        " Python packages for completion: python-lsp-server yapf isort mypy
        echo 'Installing Python LSP Packages ...'
        echo ''
        silent !pip install python-lsp-server yapf isort mypy
    endif
else
    " UNIXlike: mkdir -p ~/.vim/pack/git-plugins/start; git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
    let vim_plug_path = expand('~/.vim/pack/git-plugins/start/ale/autoload/ale.vim')
    if !filereadable(vim_plug_path)
        echo 'Installing ALE ...'
        echo ''
        silent !mkdir -p ~/.vim/pack/git-plugins/start
        silent !git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
        " Python packages for completion: python-lsp-server yapf isort mypy
        echo 'Installing Python LSP Packages ...'
        echo ''
        silent !pip install python-lsp-server yapf isort mypy
    endif
endif

" ALE option
let g:ale_enabled = 1
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['yapf', 'isort'],
\}
let g:ale_linters = {
    \ 'python': ['pylsp', 'mypy']
\}

" ALE Keybindings (OVERWRITE vim built-in keybindings)
autocmd FileType python nmap <buffer> K :ALEHover<CR>
autocmd FileType python nmap <buffer> gd :ALEGoToDefinition<CR>
autocmd FileType python nmap <buffer> gt :ALEGoToTypeDefinition<CR>
autocmd FileType python nmap <buffer> gi :ALEGoToImplementation<CR>

" ALE Keybindings (DO NOT OVERWRITE vim built-in keybindings)
nmap <buffer> gr :ALEFindReferences<CR>
nmap <buffer> g/ :ALESymbolSearch<space>
nmap <buffer> g? :execute ":ALESymbolSearch " . expand('<cword>')<CR>
nmap <buffer> ]g :ALENextWrap<CR>
nmap <buffer> [g :ALEPreviousWrap<CR>

" ALE Keybindings start with LEADER KEY
nmap <buffer> <leader>Le :ALEToggleBuffer<CR>
nmap <buffer> <leader>LE :ALEToggle<CR>
nmap <buffer> <leader>Lr :ALELint<CR>
nmap <buffer> <leader>Ls :ALELintStop<CR>
nmap <buffer> <leader>LS :ALEInfo<CR>
nmap <buffer> <leader>Lf :ALEFix<CR>

" Python completion (w/ ALE)
set omnifunc=ale#completion#OmniFunc
