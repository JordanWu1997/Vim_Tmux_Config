#!/usr/bin/env python3
# -*- coding:utf-8 -*-

import os
import shutil


def get_root_directory(start_path):
    """Finds the directory containing index.md as the root."""
    path = os.path.abspath(start_path)
    while path != "/":
        if os.path.exists(os.path.join(path, "index.md")):
            return path
        path = os.path.dirname(path)
    raise FileNotFoundError("index.md not found in any parent directory")


def update_markdown_links(old_path, new_path, root_dir):
    """Recursively updates markdown links."""
    for dirpath, _, filenames in os.walk(root_dir):
        for filename in filenames:
            if filename.endswith(".md"):
                full_path = os.path.join(dirpath, filename)
                with open(full_path, "r", encoding="utf-8") as f:
                    content = f.read()
                abs_old = os.path.abspath(old_path)
                abs_new = os.path.abspath(new_path)
                rel_old = os.path.relpath(abs_old,
                                          start=os.path.dirname(full_path))
                rel_new = os.path.relpath(abs_new,
                                          start=os.path.dirname(full_path))
                new_content = content.replace(rel_old, rel_new).replace(
                    abs_old, rel_new)
                if new_content != content:
                    print(f'[INFO] {dirpath}/{filename} updated')
                    with open(full_path, "w", encoding="utf-8") as f:
                        f.write(new_content)


def main():

    import sys

    # 1. Get filepath under cursor
    old_filepath, new_filepath = sys.argv[1], sys.argv[2]
    abs_old_path = os.path.abspath(old_filepath)
    abs_new_path = os.path.abspath(new_filepath)

    # 2. Rename/move file
    os.makedirs(os.path.dirname(abs_new_path), exist_ok=True)
    shutil.move(abs_old_path, abs_new_path)

    # 3. Find root directory with index.md
    current_dir = os.getcwd()
    root_dir = get_root_directory(current_dir)

    # 4. Update all markdown files in root
    update_markdown_links(abs_old_path, abs_new_path, root_dir)


if __name__ == '__main__':
    main()
