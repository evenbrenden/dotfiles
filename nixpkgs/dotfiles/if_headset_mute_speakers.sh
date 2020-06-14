#!/bin/bash

# When X1C7 is booted with headset connected, the PC speakers are not muted.
# Call this on startup for a stupid hack to get around that.

# if [[ -f /etc/issue && ! $(cat /etc/issue) =~ "NixOS" ]]; then
#     exit
# fi

STATE=$(pa-info 2>&1 | grep "name='Headphone Jack'" -A2 | grep ": values=" | awk '{print $2}' | sed "s/values=//g")
if [[ $STATE = "on" ]]; then
    amixer -c 0 sset 'Speaker' mute -q
    amixer -c 0 sset 'Bass Speaker' mute -q
fi
