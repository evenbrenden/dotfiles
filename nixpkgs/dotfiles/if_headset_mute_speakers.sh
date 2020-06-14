#!/bin/bash

# When X1C7 is booted with headset connected, the PC speakers are not muted.
# Call this on startup for a stupid hack to get around that. Note that:
#
# * When shutting down the machine with a headset connected, and starting
#   it up with a headset connected, and then unplugging the headset for
#   the first time since boot, the speakers need to be unmuted manually.
# * When shutting down the machine without a headset connected, and starting
#   it up with a headset connected, the headset needs to be unmuted manually.
#
# In any case, after a fresh boot and a headset unplug-then-plug, the system
# is back to normal.

if [[ -f /etc/issue && ! $(cat /etc/issue) =~ "NixOS" ]]; then
    exit
fi

STATE=$(pa-info 2>&1 | grep "name='Headphone Jack'" -A2 | grep ": values=" | awk '{print $2}' | sed "s/values=//g")
if [[ $STATE = "on" ]]; then
    amixer -c 0 sset 'Speaker' mute -q
    amixer -c 0 sset 'Bass Speaker' mute -q
fi
