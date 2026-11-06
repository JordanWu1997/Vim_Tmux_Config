#!/bin/sh
# Background loop: clear the scrollback history of panes running a listed app
# (vim, ranger, htop, ...) once it grows over a limit. With alternate-screen
# off, full-screen apps push every redraw into history, and large histories
# slow down the whole tmux server.
# Started by tmux.conf (run-shell -b); settings are global tmux options, read
# on every round, so changes apply without a restart:
# -- @history_autoclean_apps     apps to clean, space-separated ('' = none)
# -- @history_autoclean_limit    clear when history is over this many lines
# -- @history_autoclean_interval seconds between checks
# Only one loop runs: a newer one (e.g. after reloading tmux.conf) takes over
# @history_autoclean_pid and the older one exits. It also exits with the
# server. Panes in copy mode are skipped.
tmux set -g @history_autoclean_pid "$$" || exit 1

while [ "$(tmux show -gqv @history_autoclean_pid 2>/dev/null)" = "$$" ]; do
    apps=$(tmux show -gqv @history_autoclean_apps)
    limit=$(tmux show -gqv @history_autoclean_limit)
    interval=$(tmux show -gqv @history_autoclean_interval)
    case $limit in ''|*[!0-9]*) limit=5000 ;; esac
    case $interval in ''|*[!0-9]*|0) interval=60 ;; esac

    tmux list-panes -a -F '#{pane_id}	#{history_size}	#{pane_in_mode}	#{pane_current_command}' \
        | sort -u | awk -F '\t' -v limit="$limit" -v apps=" $apps " \
            '$2 > limit && $3 == 0 && index(apps, " " $4 " ") {print $1}' \
        | while IFS= read -r pane; do
            tmux clear-history -t "$pane"
        done
    sleep "$interval"
done
