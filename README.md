# Vim_Tmux_Config

Vim is a powerful text editor with long history, and Tmux is a powerful windows manager in terminal interface. With both powerful tools, coding can be more efficient. This repository is to backup my personal configuration of vim and tmux. Thanks for tutorials and configurations in my reference. I would like to share my result to other people. Since I am still a nood in vim and tmux, if there's anything I can improve in my configuration, please let me know. This configuration is tested under fedora 33.

## First time usage
### 1. Preinstall packages / dependcies
- git: https://en.wikipedia.org/wiki/Git
    - ```dnf install git```
- curl: https://en.wikipedia.org/wiki/CURL
    - ```dnf install curl```
- Nerd font (Powerline font support): https://github.com/ryanoasis/nerd-fonts
    - Under current git directory, run ``` ./vim_font_setup.sh ``` in terminal
- Tpm (Tmux plugin manager): https://github.com/tmux-plugins/tpm
    - Under current git directory, run ``` ./tpm_setup.sh ``` in terminal

### 2. Vim 
1. In terminal, run ```ln -s $PATH/vimrc .vimrc```
    - Please change $PATH to path of current git directory
2. In vim, type ```:PlugInstall``` in command line mode
    - Plugins installation should start automatically
### 3. Tmux
1. In tmux, type ```prefix + i```
    - Plug installation should start automatically
    - Note: default prefix is ```Ctrl+b```

## Basic Vim & Tmux usage
Please check https://github.com/shengjunlin/vimrc/blob/master/Vim%20%26%20Tmux.pdf

## Vim cheat sheet
This session is about key mapping and usage tip in vim. Here I only list some commonly used hotkeys that I map, as for the other hotkeys, you can use ```:nmap```, ```:vmanp``` or ```:map``` to check hotkeys in different modes respectively. For those hotkeys of plugins that I don't modified any key mappings, I will not add them to my cheat sheet except for those keys are really commonly used in daily coding.

### Hotkey map

- #### Comman key mapping
    - key ```<leader>``` is mapped to ```<space>```
    - key ```<Esc>``` in insert mode is also mapped to ```<j+k>``` and ```<k+j>``` 

- #### Function key mapping
| Key | Action | More Information |
| :-: | :----: | :--------------: |
| ```(<leader>) + F1``` | Switch to (previous)/next buffer | Buffer here is more like opened file |
| ```(<leader>) + F2``` | Swtich to (previous)/next tabe | Tabe here is more like workspace |
| ```<leader> + F3``` | Toggle NerdTree | File manager (vim-plugin) |
| ```<leader> + F4``` | Toggle TagBar | Function, variable, tag inspector (vim-plugin) |
| ```<leader> + F5``` | Show line number (abs) | Absolute |
| ```<leader> + F6``` | Show line number (rel) | Relative |
| ```F5 + F6```       | Show line number (combined) | Show relative line number except for current line |
| ```<leader> + F8``` | Toggle comment highlight | Comment will be highlight in cyan |
| ```<leader> + F9``` | Excute current file in python | Python to use need to be assigned in .vimrc |

- #### File I/O mapping
| Key | Action | More Information |
| :-: | :----: | :--------------: |
| ```<leader> + q```  | Quit current file | 
| ```<leader> + qa``` | Quit all files    |
| ```<leader> + Q ```  | Quit current file without saving |
| ```<leader> + Qa ``` | Quit all files without saving    |
| ```<leader> + w```  | Write current file | 
| ```<leader> + wa``` | Write all files    |
| ```<leader> + W ```  | Write current file without saving |
| ```<leader> + Wa ``` | Write all files without saving    |

- #### Vim split mapping
| Key | Action | More Information |
| :-: | :----: | :--------------: |
| ```<leader> + s``` | Split horizontally |
| ```<leader> + v``` | Split veritcally |
| ```<leader> + h/j/k/l``` | Move in split pane | Both vim-like keys and arrowkeys are accepted | 
| ```<leader> + H/J/K/L``` | Swap in split pane | Only vim-like keys are accepted |
| ```<leader> + </,/./>``` | Modify pane size in split pane (vertically) | -20/-5/+5/+20 columns |
| ```<leader> + _/-/=/+``` | Modify pane size in split pane (horizontally) | -20/-5/+5/+20 rows |
| ```<leader> + ==``` | Equally redistribute split pane | 

- #### Vim code-folding mapping

- #### Vim pane layout mapping

- #### Vim-Plugins hotkey

- easymotion
- nerd-commentary
- ale
- autopair
- fzf
- autopop
- gitgutter
- fzf
- indent guides
- rainbow parentheses
- nerdtree

- ### Vim usage tip
- #### Advanced vim usage

## Tmux Cheat Sheet
### Hotkey Map
- #### Tmux command hotkey
- #### Session hotkey
- #### Window hotkey
- #### Pane hotkey
- #### Tmux-Plugins hotkey
### Tmux usage tip

## Reference:
1. Fisa-vim-config          : http://fisadev.github.io/fisa-vim-config
2. shengjunlin config       : https://github.com/shengjunlin/vimrc
3. Nady's Note  VIM folding : http://nadypan.blogspot.com/2014/01/vim-fold.html
4. Use Vim as IDE           : https://github.com/yangyangwithgnu/use_vim_as_ide
5. Vim Cheat Sheet          : https://factorpad.com/tech/vim-cheat-sheet.html#structure