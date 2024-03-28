#!/usr/bin/env bash
# ============================================================================
# NEOVIM DISTRO USAGE (via $NVIM_APPNAME)
# ============================================================================
# alias vz='NVIM_APPNAME=nvim-lazyvim nvim' # LazyVim
# alias vc='NVIM_APPNAME=nvim-nvchad nvim' # NvChad
# alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
# alias va='NVIM_APPNAME=nvim-astrovim nvim' # AstroVim

# ============================================================================
# NEOVIM DISTRO INSTALLATION
# ============================================================================
# LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim-lazyvim
# NvChad
git clone https://github.com/NvChad/starter ~/.config/nvim-nvchad
# Kickstart
git clone git@github.com:nvim-lua/kickstart.nvim.git ~/.config/kickstart
# Astrovim
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim-astrovim
