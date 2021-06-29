#!/usr/bin/env bash

layout=$(setxkbmap -query | awk 'NR==3 {print $2}')

if [[ $layout == 'us' ]]; then
    setxkbmap -layout no
else
    setxkbmap -layout us
fi

pkill -x -USR1 i3status
