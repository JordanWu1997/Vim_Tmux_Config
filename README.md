# Vim_Setting

Backup for my personal vim setting and vim plugins

## Reference:

1. Fisa-vim-config          : http://fisadev.github.io/fisa-vim-config
2. shengjunlin config       : https://github.com/shengjunlin/vimrc
3. Nady's Note  VIM folding : http://nadypan.blogspot.com/2014/01/vim-fold.html
4. Use Vim as IDE           : https://github.com/yangyangwithgnu/use_vim_as_ide
5. Vim Cheat Sheet          : https://factorpad.com/tech/vim-cheat-sheet.html#structure

## First Time Useage

- Vim setting:
	- If "curl" is not installed on machine, then copy "vim" directory in "Vim_Setting" to home under user and change directory name to ".vim"
	- Copy "vimrc" file in "Vim_Setting" to home under user and change file name to ".vimrc"
- Vim plugins installations:
	- In VIM, Type ":PlugInstall" and then plugins will be installed a
utomatically


## Hot Key Table (\`, Ctrl, Tab, Leaderkey)

- \`
    - \` + \` : Word Suggestion (Suggest input keymap from present unfinished words)
    - \` + 1 : Word Suggestion (Suggest input keymap from previous finished words)

- Ctrl
    - Ctrl + h : Highlight On (Highlight Comment in Cyan)
    - Ctrl + o : Highlight Off (Highlight Comment in Gray)
    - Ctrl + n : Multi-cursor on selected word ("I" to insert words)

- Tab
    - Tab + Tab : Toggle NerdTabManager (Manage open tabs)

- Leaderkey: <space>
    - Leader + ss  : Toggle Syntastic Plugin (Default: On)
    - Leader + rb  : Toggle Rainbow Bracket (Default: Off)
    - Leader + cc  : Comment all selected lines
    - Leader + cu  : Anti-comment all selected lines
    - Leader + cy  : Comment and yank all selected lines
    - Leader + bo  : 80-character warning on
    - Leader + bf  : 80-character warning off
    - Leader + f   : Zen mode on (In normal mode)
    - Leader + F   : Zen mode off (In Zen mode)
    - Leader + b   : Move to the beginning of the line
    - Leader + e   : Move to the end of the line
    - Leader + y   : Copy (Yank) in visual mode
    - Leader + p   : Paste in normal mode
    - Leader + q/w : Quit/Write current file
    - Leader + rr  : Replace word W/O whole word criteria W/O confirmation
    - Leader + rw  : Replace word W/I whole word criteria W/O confirmation
    - Leader + rc  : Replace word W/O whole word criteria W/I confirmation
    - Leader + rcw : Replace word W/I whole word criteria W/I confirmation

- Hot Key Table (Function key):
    - Leader + F1 : Next Tab
    - Leader + F2 : Previous Tab
    - Leader + F3 : Nerd Tree (Tree Structure Directories)
    - Leader + F4 : Tagbar (Point out classes and methods)
    - Leader + F5 : Toggle Line Number (Absolute)
    - Leader + F6 : Toggle Line Number (Relative)
    - Leader + F7 : Fold Column On
    - Leader + F8 : Fold Column Off
    - Leader + F9 : Run Python (2 or 3, need to check)

## Folding Method In VIM

- __*zn : Turn off fold method*__
- __*zN : Turn on fold method*__

- Mannual fold method (VIM built-in)
    - zf : Create fold *(zf + direction + num_of_line)*
    - zx : Update fold (*Close all folds except current one*)
    - zd : Delete current fold
    - zE : Delete __*all folds*__
    - zj : Move to next fold
    - zk : Move to previous fold
    - zo : Open current fold
    - zc : Close current fold

- Hotkey
    - Leader + Leader : Toggle current fold
    - Leader + zM     : Close all folds
    - Leader + zR     : Open all folds

## Split Method in VIM

- VIM built-in method
    - Ctrl + w + hjkl: Move to different split window
    - Ctrl + w + num + "+" : Resize split window (number of lines)
    - Ctrl + w + = : Reset size of all split windows

- Hotkey
    - Leader + s : Split horizontally
    - Leader + v : Split vertically
    - Leader + - : Shrink column size
    - Leader + + : Expand column size
    - Leader + < : Shrink row size
    - Leader + > : Expand row size
    - Leader + z : Zoom in/out current window
    - Leader + h/j/k/l : Switch to pane in different location
    - Leader + H/J/K/L : Change current pane location
    - Leader + mk : Save Current Setting (Including Code Folding)
    - Leader + ld : Load Previous Setting (Including Code Folding)

## Convenient Input Premap

- < + < : \<Input>
- < + > : \<Input/>
- { + { : {Input}
- { + Enter : { CR Input }
- ' + ' + ' : ''' CR '''
- " + " + " : """ CR """
