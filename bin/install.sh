#!/usr/bin/env bash

install_vim_plugin_needed_packages () {
    sudo dnf install -y git curl
    sudo dnf install -y fzf ripgrep
    sudo dnf install -y golang
    sudo dnf install -y nodejs yarnpkg
}


install_vim_python_packages () {
    # Neovim python packages
    /usr/bin/python -m pip install neovim
    # python completion by jedi
    /usr/bin/python -m pip install jedi pynvim ipython
    # Python sort/comment/formatter
    /usr/bin/python -m pip install isort pyment yapf
    # Python debugger
    /usr/bin/python -m pip install flake8 ipdb
}

install_tmux_tpm_packages () {
    # Clone tpm repository
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_vim_font_packages () {
    # From https://github.com/ryanoasis/nerd-fonts
    # Install Nerd Font under user's home directory
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
}

install_all_vim_packages () {
    install_vim_plugin_needed_packages
    install_vim_font_packages
    install_vim_python_packages
}

install_all_tmux_packages () {
    install_tmux_tpm_packages
}

install_all_packages () {
    install_all_vim_packages
    install_all_tmux_packages
}

installation_guide () {
    echo
    echo "This installation script helps you install needed packages for vim/tmux ..."
    echo "Select following option for installation"
    echo
}

main () {
    # Installation Guide
    installation_guide
    # Installation Options
    select option in \
        'pass' \
        'all' \
        'all-vim' \
        'all-tmux'
    do
        case ${option} in
            'pass')
                echo "Just passing. No packages are installed ..."
                break
                ;;
            'all')
                echo "Install all needed packages for vim/tmux"
                install_all_packages
                break
                ;;
            'all-vim')
                echo "Install all needed packages for vim"
                install_all_vim_packages
                break
                ;;
            'all-tmux')
                echo "Install all needed packages for tmux"
                install_all_tmux_packages
                break
        esac
    done
}
