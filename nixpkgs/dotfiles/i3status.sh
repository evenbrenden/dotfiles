#!/usr/bin/env bash

# https://docs.slackware.com/howtos:window_managers:keyboard_layout_in_i3
i3status | while :
do
    read -r line

    KEYBOARD_LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}')
    KEYBOARD_LAYOUT_COLOR="#ff00ff"

    NOTIFICATIONS_STATE_FILE=~/notifications.state
    NOTIFICATIONS_STATE=$(cat $NOTIFICATIONS_STATE_FILE)
    if [[ $NOTIFICATIONS_STATE = "off" ]]; then
        NOTIFICATIONS_STATE_COLOR="#ff0000"
    else
        NOTIFICATIONS_STATE_COLOR="#ffffff"
    fi

    data="[{ \"full_text\": \"$NOTIFICATIONS_STATE\", \"color\":\"$NOTIFICATIONS_STATE_COLOR\" }, \
        { \"full_text\": \"$KEYBOARD_LAYOUT\", \"color\":\"$KEYBOARD_LAYOUT_COLOR\" },"
    echo "${line/[/$data}" || exit 1
done
