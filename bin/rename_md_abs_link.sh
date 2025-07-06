#!/usr/bin/env bash

###########################################################
# Author      : Kuan-Hsien Wu
# Contact     : jordankhwu@gmail.com
# Datetime    : 2024-11-24 09:12:53
# Description : Rename absolute path of markdown link
#               Here use rg since it's faster and ignore
#               .git directory by default for convenience
###########################################################

# Convert / to \/ for sed
SOURCE_FILENAME=$(echo $1 | sed 's/\//\\\//g')
DEST_FILENAME=$(echo $2 | sed 's/\//\\\//g')

# Use ripgrep (rg) to find all files inside vimwiki root dir
VIMWIKI_ROOT_DIR="$HOME/Documents/KNOWLEDGE_BASE"
SEARCH_ROOT_DIR="${3:-${VIMWIKI_ROOT_DIR}}"
rg "$1" "${SEARCH_ROOT_DIR}" -l0 | xargs -0 sed -i "s/${SOURCE_FILENAME}/${DEST_FILENAME}/g"
