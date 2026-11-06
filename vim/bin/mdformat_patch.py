#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# vim: set fileencoding=utf-8
"""Undo what mdformat changes in notes (markdown on stdin -> stdout).

1. Percent-encoded non-ASCII text is decoded back to readable text, e.g. a
   CJK link target %E4%B8%AD%E6%96%87.md -> 中文.md. ASCII escapes (%20,
   %25, %28, ...) are kept, so link targets stay valid markdown.
2. Doubled backslashes before a LaTeX command or escaped symbol inside math
   ($...$, $$...$$) are halved: $\\alpha$ -> $\alpha$. A LaTeX line break
   (\\ followed by a space, newline or [) is kept.
3. Checked task boxes are written as [X]: '- [x] done' -> '- [X] done'.

Fenced code blocks (``` / ~~~) and inline code spans are never changed.
"""

import re
import sys

# A run of percent-encoded bytes: %E4%B8%AD...
PERCENT_RUN = re.compile(r'(?:%[0-9A-Fa-f]{2})+')
# Inline code span: N backticks ... N backticks (same N)
CODE_SPAN = re.compile(r'(`+)(?:.|\n)*?(?<!`)\1(?!`)')
# Math: $$...$$ (may span lines) or inline $...$ on one line (Pandoc rules:
# no space after the opening $ or before the closing $, no digit after it)
MATH = re.compile(r'\$\$.+?\$\$'
                  r'|(?<![\\$])\$(?=\S)[^$\n]*?(?<=\S)\$(?!\d)', re.DOTALL)
# \\ in math that mdformat doubled: before a letter or an escaped symbol
DOUBLED_BACKSLASH = re.compile(r'\\\\(?=[A-Za-z{}_%#&$,;:!|])')
# '- [x]' / '* [x]' / '+ [x]' / '1. [x]' at the start of a list item
CHECKED_BOX = re.compile(r'^(\s*(?:[-*+]|\d+[.)])\s+)\[x\]', re.MULTILINE)
# Opening/closing code fence (up to 3 spaces of indent)
FENCE = re.compile(r'^ {0,3}(`{3,}|~{3,})')


def decode_non_ascii(run):
    """Decode the UTF-8 multi-byte sequences in a run of %XX escapes and keep
    every ASCII escape (and any invalid sequence) exactly as written."""
    tokens = re.findall(r'%[0-9A-Fa-f]{2}', run)
    out = []
    i = 0
    while i < len(tokens):
        byte = int(tokens[i][1:], 16)
        # Leading byte of a 2-4 byte UTF-8 sequence
        if 0xC2 <= byte <= 0xF4:
            size = 2 if byte < 0xE0 else 3 if byte < 0xF0 else 4
            chunk = tokens[i:i + size]
            if len(chunk) == size:
                try:
                    char = bytes(int(t[1:], 16) for t in chunk).decode('utf-8')
                except UnicodeDecodeError:
                    char = ''
                # Visible characters only (not e.g. a no-break space, which
                # would break the link target like %20 would)
                if char.isprintable() and not char.isspace():
                    out.append(char)
                    i += size
                    continue
        out.append(tokens[i])
        i += 1
    return ''.join(out)


def fix_math(match):
    return DOUBLED_BACKSLASH.sub(r'\\', match.group(0))


def fix_prose(text):
    """Apply the fixes to text that is not code."""
    text = PERCENT_RUN.sub(lambda m: decode_non_ascii(m.group(0)), text)
    text = MATH.sub(fix_math, text)
    return CHECKED_BOX.sub(r'\1[X]', text)


def fix_outside_code_spans(text):
    """Fix text between inline code spans, keep the spans themselves."""
    parts = []
    last = 0
    for span in CODE_SPAN.finditer(text):
        parts.append(fix_prose(text[last:span.start()]))
        parts.append(span.group(0))
        last = span.end()
    parts.append(fix_prose(text[last:]))
    return ''.join(parts)


def patch(text):
    """Fix the document, leaving fenced code blocks unchanged."""
    out = []
    prose = []
    fence = None
    for line in text.splitlines(keepends=True):
        match = FENCE.match(line)
        if fence is None:
            if match:
                out.append(fix_outside_code_spans(''.join(prose)))
                prose = []
                fence = match.group(1)
                out.append(line)
            else:
                prose.append(line)
        else:
            out.append(line)
            # Closing fence: same character, at least as long, nothing else
            if (match and match.group(1)[0] == fence[0]
                    and len(match.group(1)) >= len(fence)
                    and line.strip() == match.group(1)):
                fence = None
    out.append(fix_outside_code_spans(''.join(prose)))
    return ''.join(out)


def main():
    sys.stdout.write(patch(sys.stdin.read()))


if __name__ == '__main__':
    main()
