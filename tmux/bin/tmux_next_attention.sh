#!/bin/sh
# Cycle through windows with an unread agent alert, across all sessions.
# Usage: tmux_next_attention.sh <client_tty> <current_session_id:window_index>
client=$1
current=$2

first=
next=
after_current=0
windows=$(tmux list-windows -a -f '#{@watch_done}' -F '#{session_id}:#{window_index}') || exit 1

while IFS= read -r window; do
    [ -n "$window" ] || continue
    [ -n "$first" ] || first=$window
    if [ "$after_current" = 1 ]; then
        next=$window
        break
    fi
    [ "$window" = "$current" ] && after_current=1
done <<EOF
$windows
EOF

target=${next:-$first}
if [ -z "$target" ]; then
    tmux display-message -c "$client" 'No agent needs attention'
    exit 0
fi

tmux switch-client -c "$client" -t "$target" || exit 1
tmux set-window-option -u -t "$target" @watch_done
