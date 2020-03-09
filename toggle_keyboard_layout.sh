#!/bin/bash
CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
if [[ $CURRENT_LAYOUT == us ]]; then
    setxkbmap -layout no
else
    setxkbmap -layout us
fi
