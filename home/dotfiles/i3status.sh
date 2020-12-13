#!/bin/bash

# https://docs.slackware.com/howtos:window_managers:keyboard_layout_in_i3
i3status | while :
do
    read -r line

    NOTIFY_PAUSED=$(dunstctl is-paused)
    if [[ $NOTIFY_PAUSED = 'false' ]]; then
        NOTIFY_STATE_PRINT='notify'
        NOTIFY_STATE_COLOR='#ffffff'
    elif [[ $NOTIFY_PAUSED = 'true' ]]; then
        NOTIFY_STATE_PRINT='paused'
        NOTIFY_STATE_COLOR='#ff0000'
    fi
    NOTIFY_ITEM="{ \"full_text\": \"$NOTIFY_STATE_PRINT\", \"color\":\"$NOTIFY_STATE_COLOR\" }"

    XAUTOLOCK_STATUS=$(xautolock -status)
    if [[ $XAUTOLOCK_STATUS = 'Status: enabled' ]]; then
        XAUTOLOCK_STATE_PRINT='autolock'
        XAUTOLOCK_STATE_COLOR='#ffffff'
    elif [[ $XAUTOLOCK_STATUS = 'Status: disabled' ]]; then
        XAUTOLOCK_STATE_PRINT='disabled'
        XAUTOLOCK_STATE_COLOR='#ff0000'
    fi
    XAUTOLOCK_ITEM="{ \"full_text\": \"$XAUTOLOCK_STATE_PRINT\", \"color\":\"$XAUTOLOCK_STATE_COLOR\" }"

    KEYBOARD_LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}')
    KEYBOARD_LAYOUT_COLOR='#ff00ff'
    KEYBOARD_ITEM="{ \"full_text\": \"$KEYBOARD_LAYOUT\", \"color\":\"$KEYBOARD_LAYOUT_COLOR\" }"

    data="[$NOTIFY_ITEM, $XAUTOLOCK_ITEM, $KEYBOARD_ITEM,"
    echo "${line/[/$data}" || exit 1
done
