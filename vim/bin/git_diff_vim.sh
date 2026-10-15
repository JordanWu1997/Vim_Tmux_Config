#!/bin/bash

# Default behavior: open only tracked files with unstaged changes
PROMPT_MODE=false
LIST_ONLY=false
INCLUDE_UNTRACKED=false

show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Open files with unstaged Git changes in Vim for GitGutter hunk staging"
    echo ""
    echo "Options:"
    echo "  -p, --prompt     Prompt for each file before opening"
    echo "  -l, --list-only  Only list files, do not open in Vim"
    echo "  -u, --untracked  Also open untracked files (disabled by default)"
    echo "  -h, --help       Show this help message"
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -p|--prompt)
                PROMPT_MODE=true
                shift
                ;;
            -l|--list-only)
                LIST_ONLY=true
                shift
                ;;
            -u|--untracked)
                INCLUDE_UNTRACKED=true
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                echo "Unknown option: $1" >&2
                show_usage >&2
                exit 1
                ;;
        esac
    done
}

find_git_root() {
    git rev-parse --show-toplevel 2>/dev/null
}

open_files_in_vim() {
    local files=("$@")
    local files_to_open=()

    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No modified files to open."
        return
    fi

    if [[ "$PROMPT_MODE" == true ]]; then
        for file in "${files[@]}"; do
            while true; do
                if ! IFS= read -r -p "Open '$file' in vim? (y/n/q): " response; then
                    echo "Input ended."
                    return 1
                fi
                case "${response,,}" in
                    y|yes)
                        files_to_open+=("$file")
                        break
                        ;;
                    n|no)
                        break
                        ;;
                    q|quit)
                        if [[ ${#files_to_open[@]} -gt 0 ]]; then
                            echo "Opening ${#files_to_open[@]} selected files..."
                        else
                            echo "No files selected. Exiting."
                            return
                        fi
                        break 2
                        ;;
                    *)
                        echo "Please enter 'y' (yes), 'n' (no), or 'q' (quit)"
                        ;;
                esac
            done
        done

        if [[ ${#files_to_open[@]} -eq 0 ]]; then
            echo "No files selected."
            return
        fi

        files=("${files_to_open[@]}")
    fi

    # Open files in vim
    if command -v vim >/dev/null 2>&1; then
        vim -c 'GitGutterEnable' -- "${files[@]}"
    else
        echo "Error: vim not found. Make sure vim is installed and in your PATH." >&2
        return 1
    fi
}

main() {
    parse_args "$@"

    local git_root

    if git_root=$(find_git_root); then
        echo "Found git repository at: $git_root"
        cd "$git_root" || exit 1

        local diff_file
        diff_file=$(mktemp) || return 1
        trap 'rm -f -- "$diff_file"' EXIT

        echo "Running git diff --name-only for unstaged changes..."
        if git diff --name-only --diff-filter=d -z -- > "$diff_file"; then
            if [[ "$INCLUDE_UNTRACKED" == true ]]; then
                if ! git ls-files --others --exclude-standard -z -- >> "$diff_file"; then
                    echo "Error: Failed to list untracked files" >&2
                    return 1
                fi
            fi

            local files=()
            mapfile -d '' -t files < "$diff_file"
            if [[ ${#files[@]} -gt 0 ]]; then

                echo "Found ${#files[@]} file(s):"
                printf '  %s\n' "${files[@]}"

                if [[ "$LIST_ONLY" != true ]]; then
                    echo
                    open_files_in_vim "${files[@]}"
                fi
            else
                echo "No files found."
            fi
        else
            echo "Error: Failed to run git diff" >&2
            exit 1
        fi
    else
        echo "Error: No git repository found in current directory or any parent directory." >&2
        exit 1
    fi
}

main "$@"
