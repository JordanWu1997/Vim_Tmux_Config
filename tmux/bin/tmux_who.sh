#!/usr/bin/env bash
set -uo pipefail

# Colors for pretty output
RESET='\033[0m'
BOLD='\033[1m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'

PID="${1:-}"

# --- 1. Validation ---
if [[ -z "$PID" ]]; then
    echo -e "${RED}Error:${RESET} No PID provided.\nUsage: ${BOLD}$0 <PID>${RESET}"
    exit 1
fi

if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}Error:${RESET} Argument '$PID' is not a valid integer PID."
    exit 1
fi

if ! ps -p "$PID" >/dev/null 2>&1; then
    echo -e "${RED}Error:${RESET} Process with PID ${BOLD}$PID${RESET} does not exist."
    exit 1
fi

if ! tmux info >/dev/null 2>&1; then
    echo -e "${YELLOW}Warning:${RESET} No tmux server found running for user '$USER'."
    exit 1
fi

# --- 2. Gather Process Data ---
RAW_TTY=$(ps -o tty= -p "$PID" | xargs)
CMD_NAME=$(ps -o comm= -p "$PID" | xargs)
FULL_CMD=$(ps -o args= -p "$PID" | xargs)

# Handle Daemonized processes (No TTY)
if [[ "$RAW_TTY" == "?" ]]; then
    PPID=$(ps -o ppid= -p "$PID" | xargs)
    echo -e "\n ${YELLOW}▲ PROCESS IS DAEMONIZED (No TTY)${RESET}"
    echo -e "   PID ${BOLD}$PID${RESET} (${CYAN}$CMD_NAME${RESET}) is running in the background."
    echo -e "   It is entirely detached from any Tmux window."
    echo -e "   • Parent PID: ${BOLD}$PPID${RESET} ($(ps -o comm= -p "$PPID" | xargs))"
    exit 0
fi

# ps outputs "pts/1", tmux expects "/dev/pts/1"
[[ "$RAW_TTY" != /* ]] && DEV_TTY="/dev/$RAW_TTY" || DEV_TTY="$RAW_TTY"

# --- 3. Query Tmux ---
# We use a Tab (\t) delimiter to safely parse folders that might contain weird characters
PANE_DATA=$(tmux list-panes -a -F "#{pane_tty}	#{session_name}	#{window_index}	#{window_name}	#{pane_index}	#{pane_current_path}" | grep "^${DEV_TTY}	" || true)

if [[ -z "$PANE_DATA" ]]; then
    echo -e "\n ${YELLOW}▲ TTY MISMATCH${RESET}"
    echo -e "   Process $PID is on terminal ${BOLD}$DEV_TTY${RESET}, but that terminal does not belong to your Tmux."
    echo -e "   (It might belong to another user's tmux, or a normal SSH/Desktop tab)."
    exit 0
fi

IFS=$'\t' read -r t_tty t_sess t_win_idx t_win_name t_pane_idx t_path <<< "$PANE_DATA"

# --- 4. Print Results ---
echo -e "\n ${GREEN}● MATCH FOUND IN TMUX${RESET}"
echo -e " ┌────────────────────────────────────────────────────────"
echo -e " │ ${BOLD}Process:${RESET}    $PID (${CYAN}$FULL_CMD${RESET})"
echo -e " │ ${BOLD}Session:${RESET}    ${BLUE}$t_sess${RESET}"
echo -e " │ ${BOLD}Window:${RESET}     ${YELLOW}$t_win_idx${RESET} ($t_win_name)"
echo -e " │ ${BOLD}Pane:${RESET}       ${GREEN}$t_pane_idx${RESET}"
echo -e " │ ${BOLD}Directory:${RESET}  $t_path"
echo -e " └────────────────────────────────────────────────────────"
echo -e "\n ${BOLD}Teleport directly to this pane inside tmux with:${RESET}"
echo -e "   tmux select-pane -t \"${t_sess}:${t_win_idx}.${t_pane_idx}\""

echo -e "\n ${BOLD}Pane Family Tree:${RESET}"
# Portable fallback: macOS 'ps' doesn't support --forest, Linux does.
if ps --forest $$ >/dev/null 2>&1; then
    ps -f --forest -t "$RAW_TTY"
else
    ps -f -t "$RAW_TTY"
fi
