#!/bin/sh
# Tell the user that a pane needs attention (e.g. an agent finished):
# - tmux: marks the pane's window (@watch_done: magenta '!' in the status
#   bar, cleared when you visit it; prefix + M-a jumps there) and shows a
#   tmux message. Works over SSH and without a desktop.
# - desktop: notify-send, also for older servers without D-Bus env.
# Usage: tmux_notify.sh <title> <body> [pane_id]
# Called from inside a pane (e.g. an agent hook), $TMUX_PANE is that pane and
# its location is prepended to the message.
title=$1
body=$2
pane=${3:-${TMUX_PANE:-}}
if [ -n "$pane" ] && command -v tmux >/dev/null 2>&1; then
    where=$(tmux display-message -p -t "$pane" '#S:#I.#P #W' 2>/dev/null) &&
        body="$where: $body"
    # Mark the window unless someone is already looking at it
    if [ "$(tmux display-message -p -t "$pane" '#{&&:#{window_active},#{session_attached}}' 2>/dev/null)" != 1 ]; then
        tmux set-window-option -t "$pane" @watch_done 1 2>/dev/null
    fi
    # display-message expands formats: escape # so #{..}/#(..) in a window
    # name or message is shown literally (and never runs a command)
    tmux display-message "$(printf '%s' "$title: $body" | sed 's/#/##/g')" 2>/dev/null
fi
command -v notify-send >/dev/null 2>&1 || exit 0
if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
    runtime_dir="/run/user/$(id -u)"
    if [ -d "$runtime_dir" ]; then
        XDG_RUNTIME_DIR=$runtime_dir
        export XDG_RUNTIME_DIR
    fi
fi
if [ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ] && [ -n "${XDG_RUNTIME_DIR:-}" ] &&
   [ -S "$XDG_RUNTIME_DIR/bus" ]; then
    DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    export DBUS_SESSION_BUS_ADDRESS
fi
notify-send -a tmux "$title" "$body" || true
exit 0
