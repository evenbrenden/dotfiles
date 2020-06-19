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

alsactl -f /tmp/alsactl.tmp store
STATE=$(cat /tmp/alsactl.tmp | grep "Headphone Jack" -A1 | grep "value" | awk '{print $2}')
if [[ $STATE == true ]]; then
    amixer -c 0 sset 'Speaker' mute -q
    amixer -c 0 sset 'Bass Speaker' mute -q
fi
