#!/usr/bin/env python3

import os
import sys


def count_lines_in_files(directory, extensions=None, excluded_dirs=None):
    """
    Counts the number of lines in files within a directory, optionally filtering
    by file extensions and excluding specific subdirectories.

    Args:
        directory (str): The path to the directory containing the files.
        extensions (list, optional): A list of file extensions to include
            (without the leading dot). Defaults to None (count all files).
        excluded_dirs (list, optional): A list of subdirectory names to exclude
            from the search. Defaults to None (no exclusions).

    Returns:
        dict: A dictionary mapping file extensions (strings) to their corresponding
              line counts (integers).
    """
    if excluded_dirs is None:
        excluded_dirs = []
    if extensions is None:
        extensions = []

    lines_count = {}

    for root, dirs, files in os.walk(directory):
        dirs[:] = [d for d in dirs if d not in excluded_dirs]
        if any(root.startswith(ex_dir) for ex_dir in excluded_dirs):
            continue
        for file in files:
            file_path = os.path.join(root, file)
            ext = os.path.splitext(file_path)[1]
            if not extensions or ext in extensions:
                try:
                    with open(file_path, "r", encoding="utf-8") as f:
                        lines_count[ext] = lines_count.get(ext, 0) + sum(
                            1 for line in f
                        )
                except UnicodeDecodeError:
                    # print(f"Error reading file: {file_path}. Skipping...")
                    continue

    return lines_count


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(
            "Usage: python3 count_lines.py directory [extension1 ... extensionN] [-e|--exclude excluded_dir1 ... -e|--exclude excluded_dirN]"
        )
        sys.exit(1)

    directory = sys.argv[1]
    excluded_dirs_flag = {"-e", "--exclude"}
    excluded_dirs_index = next(
        (i for i, arg in enumerate(sys.argv) if arg in excluded_dirs_flag), None
    )

    if excluded_dirs_index:
        excluded_dirs = sys.argv[excluded_dirs_index + 1 :]
        extensions = (
            sys.argv[2:excluded_dirs_index] if excluded_dirs_index > 2 else None
        )
    else:
        excluded_dirs = []
        extensions = sys.argv[2:]

    lines_count = count_lines_in_files(directory, extensions, excluded_dirs)
    for ext, count in lines_count.items():
        if not ext:
            # ext = "no extension"
            continue
        print(f"Total lines in files with '{ext}' extension: {count}")
