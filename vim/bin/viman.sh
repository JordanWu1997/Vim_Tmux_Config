#!/usr/bin/env bash

if [[ -n $1 ]]; then
    /usr/bin/nvim -c "Man $1 $2" -c 'silent only' -c 'bd#'
else
    echo "[ERROR] You didn't enter the item to search"
fi
