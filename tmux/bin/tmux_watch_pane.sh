#!/bin/sh
# Watch a tmux pane; alert once its visible text stops changing.
# Usage: tmux_watch_pane.sh <pane_id> [quiet_seconds]
# Stops when window option @watch is unset (<prefix> + N)
pane=$1; quiet=${2:-15}; step=3
tmux setw -t "$pane" @watch $$          # one watcher per window
last=; still=0; alerted=0
while [ "$(tmux show -wqv -t "$pane" @watch 2>/dev/null)" = "$$" ]; do
    cur=$(tmux capture-pane -p -t "$pane" | cksum)
    if [ "$cur" = "$last" ]; then
        still=$((still + step))
    else
        last=$cur; still=0; alerted=0
        tmux setw -u -t "$pane" @watch_done
    fi
    if [ "$still" -ge "$quiet" ] && [ "$alerted" = 0 ]; then
        alerted=1
        tmux setw -t "$pane" @watch_done 1
        name=$(tmux display -p -t "$pane" '#{session_name}:#{window_index} #{window_name}')
        tmux display-message "Watch: $name is idle"
        command -v notify-send >/dev/null && notify-send -a tmux "Agent idle" "$name"
    fi
    sleep "$step"
done
