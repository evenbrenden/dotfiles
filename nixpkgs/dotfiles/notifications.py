#!/usr/bin/python3

import os.path
import sys
import subprocess

state_path = 'notifications.state'
state_on = 'on'
state_off = 'off'

# if state file no exists then create it (defaults to state off)
if not os.path.isfile(state_path):
    with open(state_path, 'w') as file:
        file.write(state_off)

# toggle state (defaults to state on)
with open(state_path, 'r+') as file:
    contents = file.read()
    state = contents.rstrip()

    if state == state_on:
        subprocess.run(['notify-send', 'DUNST_COMMAND_PAUSE'], stdout=subprocess.PIPE)
        new_state = state_off
    else:
        subprocess.run(['notify-send', 'DUNST_COMMAND_RESUME'], stdout=subprocess.PIPE)
        new_state = state_on

    file.seek(0)
    file.write(new_state)
    file.truncate()

    # https://forum.manjaro.org/t/i3-unable-to-force-i3status-refresh-with-killall/27730
    subprocess.run(['pkill', '-x', '-USR1', 'i3status'], stdout=subprocess.PIPE)
