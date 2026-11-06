#!/bin/sh
# Clear the scrollback history of tmux panes on the whole server, all panes
# or by the application running in them (pane_current_command: nvim, ranger,
# htop, intel_gpu_top, fish, ...).
# Usage: tmux_clear_all_history.sh                  list apps, ask in terminal
#        tmux_clear_all_history.sh --menu <tty>     pick app in a tmux menu
#        tmux_clear_all_history.sh --confirm <tty> [app]   tmux y/n prompt
#        tmux_clear_all_history.sh --yes [app]      clear without asking
# NOTE: the app is what runs in the pane NOW; history may also hold output
# of apps that ran there before (e.g. a fish pane after intel_gpu_top).
# Grouped sessions list the same pane more than once: count each pane once.
panes=$(tmux list-panes -a -F '#{pane_id}	#{history_size}	#{pane_current_command}' \
    | sort -u | awk -F '\t' '$2 > 0') || exit 1

# Per app (most history first): app<TAB>lines<TAB>panes
summary=$(printf '%s\n' "$panes" | awk -F '\t' 'NF {l[$3] += $2; n[$3]++}
    END {for (a in l) printf "%s\t%d\t%d\n", a, l[a], n[a]}' | sort -t '	' -k2,2nr)

# Totals for one app ($1) or all apps (no $1): "<lines> lines in <n> panes"
totals() {
    printf '%s\n' "$panes" | awk -F '\t' -v app="$1" \
        'NF && (app == "" || $3 == app) {s += $2; n++}
         END {printf "%d lines in %d panes", s, n}'
}

clear_panes() {
    msg="Cleared $(totals "$1")${1:+ ($1)}"
    printf '%s\n' "$panes" | awk -F '\t' -v app="$1" \
        'NF && (app == "" || $3 == app) {print $1}' | while IFS= read -r pane; do
        tmux clear-history -t "$pane"
    done
}

if [ -z "$panes" ]; then
    msg='No pane history to clear'
    case $1 in --menu|--confirm) tmux display-message -c "$2" "$msg" ;; *) echo "$msg" ;; esac
    exit 0
fi

case $1 in
    --yes)
        clear_panes "$2"
        tmux display-message "$msg"
        ;;
    --confirm)
        tmux confirm-before -t "$2" \
            -p "clear history of ${3:-all apps} ($(totals "$3"))? (y/n)" \
            "run-shell \"'$0' --yes '$3'\""
        ;;
    --menu)
        # Keys: a = all, 1-9 then b-z for the apps
        client=$2
        set -- -c "$client" -T '#[align=centre] Clear pane history ' \
            "all apps ($(totals))" a "run-shell \"'$0' --confirm '$client'\"" ''
        keys='1 2 3 4 5 6 7 8 9 b c d e f g h i j k l m n o p r s t u v w x y z'
        while IFS='	' read -r app lines count; do
            key=${keys%% *}; keys=${keys#* }
            set -- "$@" "$app ($lines lines in $count panes)" "$key" \
                "run-shell \"'$0' --confirm '$client' '$app'\""
        done <<EOF
$summary
EOF
        tmux display-menu "$@"
        ;;
    *)
        i=0
        printf '%3s  %-20s %10s %6s\n' '#' APP LINES PANES
        while IFS='	' read -r app lines count; do
            i=$((i + 1))
            printf '%3d  %-20s %10d %6d\n' "$i" "$app" "$lines" "$count"
        done <<EOF
$summary
EOF
        printf '\nClear which? (numbers, e.g. "1 3"; a = all; empty = cancel) '
        read -r answer
        [ -n "$answer" ] || exit 0
        if [ "$answer" = a ]; then
            clear_panes ''
            echo "$msg"
            exit
        fi
        for n in $answer; do
            app=$(printf '%s\n' "$summary" | awk -F '\t' -v n="$n" 'NR == n {print $1}')
            if [ -n "$app" ]; then clear_panes "$app"; echo "$msg"; else echo "No app #$n"; fi
        done
        ;;
esac
