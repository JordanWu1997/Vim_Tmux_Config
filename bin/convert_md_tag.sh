#!/usr/bin/env bash

###########################################################
# Author      : Kuan-Hsien Wu
# Contact     : jordankhwu@gmail.com
# Datetime    : 2024-11-24 09:12:53
# Description : Convert tag between vimwiki-style and markdown-style
###########################################################

# Check if input is a vaild file
if [[ ! -f $1 ]]; then
    echo "[ERROR] Not a valid file: $1"
    exit
fi

# Convert tags between vimwiki-style and markdown-style
case $2 in
    'v2m')
        sed -i '/^\- Tags/s/:/ \#/g' $1
        sed -i '/^\- Tags/s/Tags \# /Vimwiki:/g' $1
        sed -i '/^\- Vimwiki/s/ \#$//g' $1
        ;;
    'm2v')
        sed -i '/^\- Vimwiki/s/\#/:/' $1
        sed -i '/^\- Vimwiki/s/Vimwiki/Tags/' $1
        sed -i '/^\- Tags/s/$/:/' $1
        ;;
    *)
        echo "[ERROR] Not a valid option: $2"
esac
