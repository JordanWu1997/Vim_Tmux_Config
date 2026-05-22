#!/usr/bin/env bash

# Get the path passed from tmux
path="$1"

# 1. Replace $HOME with ~
path="${path/#$HOME/\~}"

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

# Print the final result back to tmux
echo "$res"
