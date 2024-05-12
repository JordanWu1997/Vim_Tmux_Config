# ~/.tmux.conf
# vim: syntax=tmux ft=tmux ff=unix
# ============================================================================
# My minimal (plugin-free) TMUX configuration
# ============================================================================

# NOTE: this configuration is tested in TMUX version 3.1
# - UNIX-like: sudo apt install tmux

# NOTE: Location for this configuration file (you also need to rename it ...)
# - UNIX-like: $HOME/.tmux.conf (e.g. /home/admin/.tmux.conf)

# ============================================================================
# TMUX general settings
# ============================================================================

# Set prefix [Ctrl]+[a], [Ctrl]+[b] (default: [Ctrl]+[b])
set -g prefix C-a
set -g prefix2 C-b

# Window option
set -g base-index 1
set -g renumber-windows on
set -g allow-rename on
set -g automatic-rename off

# Window option
setw -g pane-base-index 1
setw -g aggressive-resize on

# Master pane size
set -g main-pane-height "50%"
set -g main-pane-width "50%"

# Close TMUX after closing current session
set -g detach-on-destroy off

# Vi mode (use keys of copy-mode-vi instead of copy-mode)
set -g mode-keys vi
set -g status-keys vi

# Miscellaneous TMUX settings
set -g default-terminal "xterm-256color"
set -g display-time 3000
set -g display-panes-time 3000
set -g escape-time 0
set -g repeat-time 450
set -g history-limit 30000
set -g visual-activity on
set -g focus-events on
set -g mouse on

# ============================================================================
# TMUX buffer and copymode
# ============================================================================


# Clipboard is set to "on" for gnome-terminal emulator, but MUST be set to "off"
# for kitty or other terminal emulator supports set-clipboard
# -- https://github.com/tmux/tmux/wiki/Clipboard
set -g set-clipboard on

# Set Copy/Paste Mode
bind [ copy-mode
bind ] paste-buffer
bind = choose-buffer

# Set Copy/Paste Mode (VIM-like key binding in copy-mode-vi)
# -- https://superuser.com/questions/395158/tmux-copy-mode-select-text-block
# -- TMUX version < 2.5
#bind-key -t vi-copy 'v' begin-selection
#bind-key -t vi-copy 'C-v' rectangle-toggle
#bind-key -t vi-copy 'y' copy-selection
# -- TMUX version >= 2.5
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi C-v send -X rectangle-toggle \; send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection-and-cancel

# Quick enter copy mode for screen scrolling
bind \; copy-mode
bind -T copy-mode-vi \; send -X cancel
bind -T copy-mode-vi C-[ send -X cancel

# ============================================================================
# TMUX session/pane/window option
# ============================================================================

# Switch to last pane
bind -r ` last-pane
# Switch to last window
bind -r \~ last-window

# Create/Kill window
bind C new-window -c "#{pane_current_path}"
bind X confirm-before -p "kill window #W? (y/n)" "kill-window"
bind C-S-x confirm-before -p "kill all other windows? (y/n)" "kill-window -a"

# Split window
unbind \%; bind \% split-window -h -c "#{pane_current_path}"
unbind \"; bind \" split-window -v -c "#{pane_current_path}"

# Split full window
bind M-\% split-window -fh -c "#{pane_current_path}"
bind M-\" split-window -fv -c "#{pane_current_path}"

# Change focus
bind -n C-h select-pane -L
bind -n C-j select-pane -D
bind -n C-k select-pane -U
bind -n C-l select-pane -R

# Vimium-like key for session switch
bind -r j switch-client -n
bind -r k switch-client -p

# Vimium-like key for window select
bind -r l select-window -t +1
bind -r h select-window -t -1

# Vim-like key for pane/window swap (focus stays)
bind -r J swap-pane -t +1\; select-pane
bind -r K swap-pane -t -1\; select-pane
bind -r L swap-window -t +1\; select-window -t +1
bind -r H swap-window -t -1\; select-window -t -1

# Vim-like key for pane resize (No need to press prefix key constantly)
bind -r M-j resize-pane -D 1
bind -r M-k resize-pane -U 1
bind -r M-l resize-pane -R 1
bind -r M-h resize-pane -L 1

# Manipulate mark pane (<prefix>+[m])
bind -r M-\; swap-pane
bind -r | join-pane -h
bind -r _ join-pane -v

# ============================================================================
# TMUX miscellaneous
# ============================================================================
# NOTE: Update $DISPLAY in TMUX session
#
# (1) For bash shell, add following function to ~/.bashrc
#
## Update TMUX display (e.g. localhost:XX -> localhost:XX)
#function tmux_update_display {
#    export LAST_DISPLAY=$DISPLAY
#    export DISPLAY=$(tmux show-env | sed -n 's/^DISPLAY=//p')
#    echo "UPDATE_TMUX_DISPLAY: $LAST_DISPLAY (OLD) -> $DISPLAY (NEW)"
#}
#
# (2) For fish shell, add following function to ~/.config/fish/config.fish
#
## Update TMUX display (e.g. localhost:XX -> localhost:XX)
#function tmux_update_display
#    set LAST_DISPLAY $DISPLAY
#    set DISPLAY (tmux show-env | sed -n 's/^DISPLAY=//p')
#    echo "UPDATE_TMUX_DISPLAY: $LAST_DISPLAY (OLD) -> $DISPLAY (NEW)"
#end

# Disable scrollback clearing
set -g alternate-screen off

# Setup load change of .tmux.conf
bind R source-file ~/.tmux.conf \; display-message "source-file ~/.tmux.conf"

# Toggle mouse mode
bind M set mouse \; display-message "set mouse"

# Toggle pane input synchronization
bind C-s setw synchronize-panes

# Shell shortcut need to be remapped by prefix+...
bind -r C-b send-keys 'C-b'
bind -r C-h send-keys 'C-h'
bind -r C-j send-keys 'C-j'
bind C-k send-keys 'C-k'
bind C-a send-keys 'C-a'

# Clear current pane output but keep scrollback history
bind a send-keys 'C-l'
bind C-l send-keys 'C-l'
# Clear current pane output and scrollback history
bind C-S-l confirm-before -p "clear scrollback history? (y/n)" "clear-history \; display-message 'scrollback history cleared'"

# Let Home/End work in TMUX
bind -n Home send Escape "OH"
bind -n End send Escape "OF"

# ============================================================================
# TMUX statusline / titlebar
# ============================================================================

# Toggle TMUX statusline/borderline
bind B set status
bind b set pane-border-status
