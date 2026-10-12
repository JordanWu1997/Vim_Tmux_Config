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
        # Attention is acknowledged by the jump key or by turning watch off.
        # Screen output alone may arrive before the user sees the alert.
    fi
    # A turn-completion event suppresses the idle fallback for that same screen,
    # including when the user acknowledges the event before this poll runs.
    event_screen=$(tmux show -wqv -t "$pane" @watch_event_screen 2>/dev/null)
    if [ -n "$event_screen" ]; then
        if [ "$cur" = "$event_screen" ]; then
            alerted=1
        else
            tmux setw -u -t "$pane" @watch_event_screen
        fi
    fi
    if [ "$still" -ge "$quiet" ] && [ "$alerted" = 0 ]; then
        alerted=1
        # A completion hook takes precedence over the idle heuristic, and an
        # unread alert must not be sent repeatedly after intermittent output.
        if [ -z "$(tmux show -wqv -t "$pane" @watch_done 2>/dev/null)" ]; then
            tmux setw -t "$pane" @watch_done idle
            name=$(tmux display -p -t "$pane" '#{session_name}:#{window_index} #{window_name}')
            tmux display-message "Watch: $name is idle"
            command -v notify-send >/dev/null && notify-send -a tmux "Agent idle" "$name"
        fi
    fi
    sleep "$step"
done
