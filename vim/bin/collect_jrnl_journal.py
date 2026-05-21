#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# vim: set fileencoding=utf-8
"""

# CLI Tool jrnl

- Refernces
  - https://github.com/jrnl-org/jrnl?tab=readme-ov-file
  - https://jrnl.sh/en/stable/reference-config-file/
  - https://jrnl.sh/en/stable/formats/
- Configuration
  - ~/.config/jrnl/jrnl.yaml
- Usage
  - Add journal: jrnl \<JOURNAL_TO_WRITE>
  - Edit journal (on today): jrnl --edit (-on today)
  - Expot journal (on today): jrnl --format markdown (-on today)
- Alias for SHELL e.g., BASH, FISH, etc.
  ```sh
  alias jj='jrnl'
  alias jl='jrnl --format markdown -on today'
  alias je='jrnl --edit -on today'
  alias jL='jrnl --format markdown'
  alias jE='jrnl --edit'
  ```
"""

import argparse
import datetime
import os
import re
import sys

import yaml


def filter_and_format_journal(filename, date=None):
    """
    Reads the journal file, filters entries for the current date,
    and formats them as a Markdown string.
    """
    # 1. Get today's date in the format used in the log file, e.g., '2025-10-26'
    # Current time is October 26, 2025, so this will be '2025-10-26'
    if date is None:
        date = datetime.date.today().strftime('%Y-%m-%d')

    # 2. Define the regex pattern to capture the full timestamp and the log content.
    # The pattern is now more robust to account for the full, possibly ambiguous, timestamp format:
    #   ^\[ : Start of line and opening bracket
    #   (\d{4}-\d{2}-\d{2}) : Captures the DATE (Group 1)
    #   \s : Matches space
    #   (\d{2}:\d{2}:\d{2}) : Captures the 24-hour TIME (Group 2)
    #   (?:\s[AP]M)? : [REMOVED] Non-capturing group for optional AM/PM indicator
    #   \s*\]\s* : Matches space, closing bracket, and optional spaces
    #   (.*) : Captures the rest of the line as the content (Group 3)
    LOG_PATTERN = re.compile(
        r'^\[(\d{4}-\d{2}-\d{2})\s(\d{2}:\d{2}:\d{2})\s*\]\s*(.*)$')

    date_entries = []
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.rstrip(
                )  # Use rstrip to remove trailing whitespace but keep internal newlines

                # Try to match the log pattern
                match = LOG_PATTERN.match(line)

                if match:
                    log_date = match.group(1)
                    log_time = match.group(2)
                    log_content = match.group(3).strip()

                    # 3. Filter: Only keep entries where the date matches today
                    if log_date == date:
                        # Store the time and content for later formatting
                        date_entries.append((log_time, log_content))

                # Handling multi-line entries:
                # If an entry is already being built, append subsequent non-timestamped lines.
                # Only append if the line isn't empty AND we have a previous entry to append to.
                elif date_entries and line:
                    # Append this line as a continuation of the *last* captured entry's content
                    last_time, last_content = date_entries[-1]
                    # Add a newline and the current line's content
                    new_content = f"{last_content}\n{line}"
                    date_entries[-1] = (last_time, new_content)

    except FileNotFoundError:
        print(f"Error: The file '{filename}' was not found.", file=sys.stderr)
        return None

    # 4. Format the output

    # If there are no entries for today
    if not date_entries:
        return f"# {date} Log\n\nNo entries found for today."

    # Start the Markdown output with the heading
    markdown_output = [f"# {date} Journal\n"]

    # Add each entry in the desired format
    for log_time, log_content in date_entries:
        # The line format: {TIME}: {Content}
        markdown_output.append(f"## {log_time}: {log_content}\n")

    return "\n".join(markdown_output)


# --- Main Execution ---
if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('--date',
                        default=None,
                        help='YYYY-MM-DD HH:MM:SS AM/PM')
    parser.add_argument('--journal_file_path', default=None)
    args = parser.parse_args()

    # Load journal file path
    if args.journal_file_path is None:
        with open(f"{os.environ.get('HOME')}/.config/jrnl/jrnl.yaml",
                  'r') as config:
            config_data = yaml.safe_load(config)
        journal_file_path = config_data['journals']['default']['journal']
        journal_file_path = os.path.expandvars(journal_file_path)

    # Main
    markdown_log = filter_and_format_journal(journal_file_path, date=args.date)
    if markdown_log:
        print(markdown_log)
