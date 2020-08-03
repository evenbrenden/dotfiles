#!/bin/bash

# https://docs.slackware.com/howtos:window_managers:keyboard_layout_in_i3
i3status | while :
do
    read -r line

    KEYBOARD_LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}')
    KEYBOARD_LAYOUT_COLOR="#ff00ff"

    NOTIFICATIONS_PAUSED=$(dunstctl is-paused)
    if [[ $NOTIFICATIONS_PAUSED = "false" ]]; then
        NOTIFICATIONS_STATE_PRINT="on"
        NOTIFICATIONS_STATE_COLOR="#ffffff"
    elif [[ $NOTIFICATIONS_PAUSED = "true" ]]; then
        NOTIFICATIONS_STATE_PRINT="off"
        NOTIFICATIONS_STATE_COLOR="#ff0000"
    fi

    data="[{ \"full_text\": \"$NOTIFICATIONS_STATE_PRINT\", \"color\":\"$NOTIFICATIONS_STATE_COLOR\" }, \
        { \"full_text\": \"$KEYBOARD_LAYOUT\", \"color\":\"$KEYBOARD_LAYOUT_COLOR\" },"
    echo "${line/[/$data}" || exit 1
done
