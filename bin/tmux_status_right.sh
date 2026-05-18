#!/usr/bin/env bash

CLIENT_WIDTH="$1"
SESSION_WINDOWS="$2"
CLIENT_PREFIX="$3"
PANE_IN_MODE="$4"
SYNCHRONIZE_PANES="$5"
SESSION_NAME="$6"
HOSTNAME="$7"

# Fetch system time structures
D_SHORT=$(date +"%H:%M")
D_MED=$(date +"%d %H:%M")
D_LONG=$(date +"%m-%d %H:%M")
D_FULL=$(date +"%Y-%m-%d %H:%M")

awk -v width="$CLIENT_WIDTH" \
    -v win_count="$SESSION_WINDOWS" \
    -v prefix="$CLIENT_PREFIX" \
    -v in_mode="$PANE_IN_MODE" \
    -v sync="$SYNCHRONIZE_PANES" \
    -v s_name="$SESSION_NAME" \
    -v host="$HOSTNAME" \
    -v d_short="$D_SHORT" \
    -v d_med="$D_MED" \
    -v d_long="$D_LONG" \
    -v d_full="$D_FULL" '
BEGIN {
    window_multiplier = 12

    # 1. Colors for Right Status
    if (prefix == "1") {
        t_fg = "colour15"; t_bg = "default"
        #s_fg = "colour0";    s_bg = "colour15"
        s_fg = "colour232";    s_bg = "colour15"
    } else if (in_mode == "1") {
        t_fg = "colour3";  t_bg = "default"
        s_fg = "colour15"; s_bg = "colour3"
    } else if (sync == "1") {
        t_fg = "colour1";  t_bg = "default"
        s_fg = "colour15"; s_bg = "colour1"
    } else {
        t_fg = "colour2";  t_bg = "default"
        s_fg = "colour15"; s_bg = "colour2"
    }

    # 2. Hostname length logic for target time variant string
    host_len = length(host)
    if (host_len <= 5)       { date_str = d_short }
    else if (host_len <= 12) { date_str = d_med }
    else if (host_len <= 15) { date_str = d_long }
    else                     { date_str = d_full }

    # 3. Precise Char Sum Offset Calculation
    char_offset = length(date_str) + 2 + length(s_name) + 2

    # 4. Space Validation Check (Using half the total client width)
    usable_width = width / 2
    required_space = (win_count * window_multiplier) + char_offset

    if (required_space > width) {
        # Near Full/No space layout placeholder
        sess_block = "#[fg=" s_fg ",bg=" s_bg ",bold] " s_name " "
        print sess_block
    } else {
        # Normal Right Status Output
        time_block = "#[fg=" t_fg ",bg=" t_bg ",bold] " date_str " "
        sess_block = "#[fg=" s_fg ",bg=" s_bg ",bold] " s_name " "
        print time_block sess_block
    }
}'
