#!/bin/sh
# Watch one pane's visible screen and notify once after a quiet interval.
# This detects inactivity, not agent completion.
# Usage: tmux_watch_pane.sh <pane_id> [quiet_seconds]
pane=${1:-}
quiet=${2:-15}
step=3
case $quiet in ''|*[!0-9]*|0) exit 2 ;; esac
[ -n "$pane" ] || exit 2

[ "$(tmux show -pqv -t "$pane" @watch 2>/dev/null)" = on ] || exit 0
tmux set-option -p -t "$pane" @watch_pid "$$" || exit 1
tmux set-option -p -u -t "$pane" @watch_quiet

last=
changed_at=$(date +%s)
alerted=0
while [ "$(tmux show -pqv -t "$pane" @watch 2>/dev/null)" = on ] &&
      [ "$(tmux show -pqv -t "$pane" @watch_pid 2>/dev/null)" = "$$" ]; do
    screen=$(tmux capture-pane -p -t "$pane" 2>/dev/null) || break
    cur=$(printf '%s' "$screen" | cksum)
    now=$(date +%s)
    if [ "$cur" != "$last" ]; then
        last=$cur
        changed_at=$now
        alerted=0
        tmux set-option -p -u -t "$pane" @watch_quiet
    elif [ "$alerted" = 0 ] && [ $((now - changed_at)) -ge "$quiet" ]; then
        alerted=1
        tmux set-option -p -t "$pane" @watch_quiet on
        name=$(tmux display-message -p -t "$pane" '#{session_name}:#{window_index}.#{pane_index} #{window_name}')
        tmux display-message "Screen quiet: $name"
        "$(dirname "$0")/tmux_notify.sh" 'Pane screen quiet' "$name: no visible change for $quiet seconds"
    fi
    sleep "$step"
done

# Pane options disappear automatically when their pane closes.
if [ "$(tmux show -pqv -t "$pane" @watch_pid 2>/dev/null)" = "$$" ]; then
    tmux set-option -p -u -t "$pane" @watch_pid
fi
