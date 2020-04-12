#!/bin/bash

# https://docs.slackware.com/howtos:window_managers:keyboard_layout_in_i3
i3status | while :
do
    read line
    LANG=$(setxkbmap -query | awk '/layout/{print $2}')
    data="[{ \"full_text\": \"$LANG\", \"color\":\"#ff00ff\" },"
    echo "${line/[/$data}" || exit 1
done
