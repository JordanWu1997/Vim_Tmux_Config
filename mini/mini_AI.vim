" ~/.mini_AI.vim
" vim: ft=vim
" ============================================================================
" My minimal cross-platfrom vim config for normal usage and python coding
" ============================================================================

" vim-ai installation
if has('win32')
    " Windows: mkdir -p ~/vimfiles/pack/git-plugins/start; git clone --depth 1 https://github.com/dense-analysis/ale.git ~/vimfiles/pack/git-plugins/start/ale
    let home = expand('$HOME')
    let vim_plug_path = home . '\vimfiles\pack\git-plugins\start\vim-ai\autoload\vim_ai.vim'
    if !filereadable(vim_plug_path)
        echo 'Installing VIM-AI ...'
        echo ''
        silent execute '!mkdir "' . home . '\vimfiles\pack\git-plugins\start\vim-ai'
        silent execute '!git clone https://github.com/madox2/vim-ai.git' '"' . home . '\vimfiles\pack\git-plugins\start\vim-ai"'
    endif
else
    " UNIXlike: mkdir -p ~/.vim/pack/git-plugins/start; git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
    let vim_plug_path = expand('~/.vim/pack/git-plugins/start/vim-ai/autoload/vim_ai.vim')
    if !filereadable(vim_plug_path)
        echo 'Installing VIM-AI ...'
        echo ''
        silent !mkdir -p ~/.vim/pack/git-plugins/start
        silent !git clone https://github.com/madox2/vim-ai.git ~/.vim/pack/git-plugins/start/vim-ai
    endif
endif

" Vim-AI configuration
let s:vim_ai_endpoint_url = "http://localhost:11434/v1/chat/completions"
let s:vim_ai_model = "qwen2.5-coder:32b"
"let s:vim_ai_model = "codestral:latest"
"let s:vim_ai_model = "qwq:latest"
let s:vim_ai_temperature = 0.3
let s:vim_ai_chat_config = #{
    \  engine: "chat",
    \  options: #{
    \    model: s:vim_ai_model,
    \    temperature: s:vim_ai_temperature,
    \    endpoint_url: s:vim_ai_endpoint_url,
    \    auth_type: 'none',
    \    max_tokens: 0,
    \    request_timeout: 90,
    \  },
    \  ui: #{
    \    code_syntax_enabled: 1,
    \  },
    \}
let s:vim_ai_edit_config = #{
    \  engine: "chat",
    \  options: #{
    \    model: s:vim_ai_model,
    \    temperature: s:vim_ai_temperature,
    \    endpoint_url: s:vim_ai_endpoint_url,
    \    auth_type: 'none',
    \    max_tokens: 0,
    \    request_timeout: 90,
    \  },
    \  ui: #{
    \    paste_mode: 1,
    \  },
    \}
let g:vim_ai_chat = s:vim_ai_chat_config
let g:vim_ai_complete = s:vim_ai_edit_config
let g:vim_ai_edit = s:vim_ai_edit_config
