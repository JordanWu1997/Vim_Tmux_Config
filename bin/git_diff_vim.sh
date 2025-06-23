#!/bin/bash

# Default behavior: open all files
PROMPT_MODE=false
LIST_ONLY=false

show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Find git repository and open modified files in vim"
    echo ""
    echo "Options:"
    echo "  -p, --prompt     Prompt for each file before opening"
    echo "  -l, --list-only  Only list modified files, do not open in vim"
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
    local current_dir="$(pwd)"

    while [[ "$current_dir" != "/" ]]; do
        if [[ -d "$current_dir/.git" ]]; then
            echo "$current_dir"
            return 0
        fi
        current_dir="$(dirname "$current_dir")"
    done

    # Check root directory
    if [[ -d "/.git" ]]; then
        echo "/"
        return 0
    fi

    return 1
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
                read -p "Open '$file' in vim? (y/n/q): " response
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
        vim "${files[@]}"
    else
        echo "Error: vim not found. Make sure vim is installed and in your PATH." >&2
    fi
}

main() {
    parse_args "$@"

    local git_root

    if git_root=$(find_git_root); then
        echo "Found git repository at: $git_root"
        cd "$git_root" || exit 1

        echo "Running git diff --name-only..."
        local diff_output
        if diff_output=$(git diff --name-only 2>/dev/null); then
            if [[ -n "$diff_output" ]]; then
                # Convert to array
                local files=()
                while IFS= read -r line; do
                    [[ -n "$line" ]] && files+=("$line")
                done <<< "$diff_output"

                echo "Found ${#files[@]} modified file(s):"
                printf '  %s\n' "${files[@]}"

                if [[ "$LIST_ONLY" != true ]]; then
                    echo
                    open_files_in_vim "${files[@]}"
                fi
            else
                echo "No modified files found."
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
