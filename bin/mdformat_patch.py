#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# vim: set fileencoding=utf-8

import re
import sys
import urllib.parse


def fix_math_blocks(text):
    # Pattern to match both block ($$) and inline ($) math
    pattern = re.compile(r'(\$\$.*?\$\$|\$.*?\$)', re.DOTALL)

    def unescape_latex(match, verbose=False):
        original_block = match.group(0)
        # Revert double backslashes to single
        fixed_block = original_block.replace('\\\\', '\\')

        # Log exactly what was found and changed to the console
        if verbose:
            print(f"--- MATCH FOUND ---", file=sys.stderr)
            print(f"Original: {repr(original_block)}", file=sys.stderr)
            print(f"Fixed:    {repr(fixed_block)}\n", file=sys.stderr)

        return fixed_block

    return pattern.sub(unescape_latex, text)


def main():
    # Read the text passed from Vim
    text = sys.stdin.read()

    # Goal 1: Decode URLs (e.g., %E4%B8... -> 中文連結)
    text = urllib.parse.unquote(text)

    # Goal 2: Fix LaTeX escapes strictly inside math environments
    text = fix_math_blocks(text)

    # Goal 3: Standardize checkboxes
    # (Note: Change this to text.replace('[X]', '[x]') if you prefer lowercase)
    text = text.replace('[x]', '[X]')

    # Return the patched text back to Vim
    sys.stdout.write(text)


if __name__ == '__main__':
    main()
