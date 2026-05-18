#!/usr/bin/env bash

CLIENT_WIDTH="$1"
SESSION_WINDOWS="$2"
CLIENT_PREFIX="$3"
PANE_IN_MODE="$4"
SYNCHRONIZE_PANES="$5"
SESSION_NAME="$6"
HOSTNAME="$7"

awk -v width="$CLIENT_WIDTH" \
    -v win_count="$SESSION_WINDOWS" \
    -v prefix="$CLIENT_PREFIX" \
    -v in_mode="$PANE_IN_MODE" \
    -v sync="$SYNCHRONIZE_PANES" \
    -v s_name="$SESSION_NAME" \
    -v host="$HOSTNAME" '
BEGIN {
    # Approx width multiplier per window element
    window_multiplier = 15

    # 1. Colors for Left Status
    if (prefix == "1") {
        #s_fg = "colour0";  s_bg = "colour15"
        s_fg = "colour232";  s_bg = "colour15"
        h_fg = "colour15"; h_bg = "default"
    } else if (in_mode == "1") {
        s_fg = "colour15"; s_bg = "colour3"
        h_fg = "colour3";  h_bg = "default"
    } else if (sync == "1") {
        s_fg = "colour15"; s_bg = "colour1"
        h_fg = "colour1";  h_bg = "default"
    } else {
        s_fg = "colour15"; s_bg = "colour2"
        h_fg = "colour2";  h_bg = "default"
    }

    host_offset = length(host)
    if (host_len <= 5)       { host_offset = 5 }
    else if (host_len <= 8)  { host_offset = 8 }
    else if (host_len <= 11) { host_offset = 11 }
    else if (host_len <= 14) { host_offset = 14 }
    else                     { host_offset = 16 }

    # 2. Precise Char Sum Offset Calculation
    char_offset = length(s_name) + 2 + host_offset + 2 + 4

    # 3. Space Calculation (Using half the total client width)
    usable_width = width / 2
    required_space = (win_count * window_multiplier) + char_offset

    if (required_space > width) {
        # Drop hostname block to save space if getting crowded
        s_block = "#[fg=" s_fg ",bg=" s_bg ",bold] " s_name " "
        print s_block
    } else {
        # Full Left Status Output
        s_block = "#[fg=" s_fg ",bg=" s_bg ",bold] " s_name " "
        h_block = "#[default]#[fg=" h_fg ",bg=" h_bg ",bold] " host " "
        print s_block h_block
    }
}'
