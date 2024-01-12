# ~/.tmux.conf
# vim: ft=tmux
# ============================================================================
# My minimal TMUX configuration
# ============================================================================

# Note: this configuration is tested in TMUX version 3.1
# - UNIX-like: sudo apt install tmux

# Note: Location for this configuration file (you also need to rename it ...)
# - UNIX-like: $HOME/.tmux.conf (e.g. /home/admin/.tmux.conf)

# Set prefix [Ctrl]+[b], [Ctrl]+[a] (default: [Ctrl]+[b])
set -g prefix C-b
set -g prefix2 C-a

# Terminal
set -g default-terminal "xterm-256color"

# Window option
set -g base-index 1
set -g renumber-windows on
setw -g aggressive-resize on
setw -g pane-base-index 1

# Vi mode (use keys of copy-mode-vi instead of copy-mode)
set -g mode-keys vi
set -g status-keys vi

# Let Home/End work in TMUX
bind -n Home send Escape "OH"
bind -n End send Escape "OF"

# Buffer settings
set -g set-clipboard on
bind [ copy-mode
bind ] paste-buffer
bind = choose-buffer

# Split window
unbind \%; bind \% split-window -v -c "#{pane_current_path}"
unbind \"; bind \" split-window -h -c "#{pane_current_path}"

# Split full window
bind M-\% split-window -fv -c "#{pane_current_path}"
bind M-\" split-window -fh -c "#{pane_current_path}"

# Mark pane operation
bind -r M-\; swap-pane
bind -r M-\: join-pane

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

# Scrollback history
# Disable scrollback clearing
set -g alternate-screen off
# Clear current pane output and scrollback history
bind C-S-l confirm-before -p "clear scrollback history? (y/n)" "clear-history \; display-message 'scrollback history cleared'"

# Setup load change of .tmux.conf
bind R source-file ~/.tmux.conf \; display-message "source-file ~/.tmux.conf"

# NOTE: Update $DISPLAY in TMUX session
#
# (1) For bash shell, add following function to ~/.bashrc
#
## Update tmux display (e.g. localhost:XX -> localhost:XX)
#function tmux_update_display {
#    export LAST_DISPLAY=$DISPLAY
#    export DISPLAY=$(tmux show-env | sed -n 's/^DISPLAY=//p')
#    echo "UPDATE_TMUX_DISPLAY: $LAST_DISPLAY (OLD) -> $DISPLAY (NEW)"
#}
#
# (2) For fish shell, add following function to ~/.config/fish/config.fish
#
## Update tmux display (e.g. localhost:XX -> localhost:XX)
#function tmux_update_display
#    set LAST_DISPLAY $DISPLAY
#    set DISPLAY (tmux show-env | sed -n 's/^DISPLAY=//p')
#    echo "UPDATE_TMUX_DISPLAY: $LAST_DISPLAY (OLD) -> $DISPLAY (NEW)"
#end
