#!/usr/bin/env bash

# Get the path passed from tmux
path="$1"
display="$2"
show_short_path="${3:-1}"
show_display="${4:-0}"

# -----------------------------------------------------------------------------
# DISPLAY formatting
# -----------------------------------------------------------------------------

display_str=""

# NOTE: Hard-coded ]-[ for [PATH]-[DISPLAY] for active pane
if [[ "$show_display" == "1" && -n "$display" ]]; then

    # localhost:10.0 -> L:10.0
    if [[ "$display" =~ ^localhost:(.*)$ ]]; then
        display_str="]-[L:${BASH_REMATCH[1]}"

    # unix:0 -> U:0
    elif [[ "$display" =~ ^unix:(.*)$ ]]; then
        display_str="]-[U:${BASH_REMATCH[1]}"

    # :0
    elif [[ "$display" =~ ^:(.*)$ ]]; then
        display_str="]-[:${BASH_REMATCH[1]}"

    # fallback
    else
        display_str=" ]-[$display"
    fi
fi

# -----------------------------------------------------------------------------
# Path shortening
# -----------------------------------------------------------------------------

# 1. Replace $HOME with ~
path="${path/#$HOME/\~}"

if [[ "$show_short_path" != 1 ]]; then
    res="$path"
else
    # 2. Split the path by '/' into an array
    IFS='/' read -ra parts <<< "$path"
    len=${#parts[@]}

    res=""
    # Handle absolute paths at the root (preserve the leading slash)
    [[ "$path" == /* ]] && res="/"

    # 3. Iterate through all parts of the path
    for (( i=0; i<len; i++ )); do
        p="${parts[i]}"

        # Skip empty parts (caused by leading slashes or consecutive slashes)
        [[ -z "$p" ]] && continue

        if (( i == len - 1 )); then
            # If it's the last part (current directory), keep the full name
            res+="$p"
        else
            # If it's not the last part, collapse it
            if [[ "$p" == "~" ]]; then
                res+="~/"
            elif [[ "${p:0:1}" == "." ]]; then
                # If it's a hidden folder, keep the dot and the first letter (e.g., .c/)
                res+="${p:0:2}/"
            else
                # Otherwise, just keep the first letter
                res+="${p:0:1}/"
            fi
        fi
    done
fi

# -----------------------------------------------------------------------------
# Output
# -----------------------------------------------------------------------------

# Print the final result back to tmux
printf '%s%s\n' "$res" "$display_str"
