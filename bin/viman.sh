#!/usr/bin/env bash

/usr/bin/nvim -c "Man $1 $2" -c 'silent only' -c 'bd#'
