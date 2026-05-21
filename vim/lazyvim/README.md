# Quick Start with LazyVim

- References

  - https://www.lazyvim.org/
  - https://github.com/neovim/neovim/releases/tag/v0.10.3
  - https://github.com/vimwiki/vimwiki/issues/1130

- Requirements

  - Neovim >= 0.9.0 (need to be built with LuaJIT)
    - In this configuration, I just use neovim appimage

- Use lazyvim along side neovim

  1. Clone lazyvim configuration from github

     ```bash
     git clone https://github.com/LazyVim/LazyVim.git
     ```

  2. For fish shell, add neovim function using lazyvim configuration

     ```fish
     function lvim
         set -gx NVIM_APPNAME lazyvim
         $HOME/.local/bin/nvim.appimage $argv
     end
     ```

- Plug-in

  - `ellisonleao/gruvbox.nvim`
  - `christoomey/vim-tmux-navigator`
  - `vimwiki/vimwiki`
