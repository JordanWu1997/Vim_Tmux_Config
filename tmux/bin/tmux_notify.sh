#!/bin/sh
# Send a desktop notification from tmux, including older servers without D-Bus env.
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
notify-send -a tmux "$1" "$2" || true
