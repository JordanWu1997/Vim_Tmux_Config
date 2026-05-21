#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# vim: set fileencoding=utf-8
r"""
[ADD MODULE DOCUMENTATION HERE]

# ========================================================================== #
#  _  __   _   _                                          __        ___   _  #
# | |/ /  | | | |  Author: Jordan Kuan-Hsien Wu           \ \      / / | | | #
# | ' /   | |_| |  E-mail: jordankhwu@gmail.com            \ \ /\ / /| | | | #
# | . \   |  _  |  Github: https://github.com/JordanWu1997  \ V  V / | |_| | #
# |_|\_\  |_| |_|  Datetime: 2026-05-15 17:26:19             \_/\_/   \___/  #
#                                                                            #
# ========================================================================== #
"""

import argparse

parser = argparse.ArgumentParser(description="Example argparse template")
parser.add_argument("input_files", nargs="+", help="Input file paths")
parser.add_argument("-o",
                    "--output_dir",
                    type=str,
                    default="./output",
                    help="Output directory (default: ./output)")
parser.add_argument("-v",
                    "--verbose",
                    action="store_true",
                    help="Enable verbose mode")
args = parser.parse_args()
