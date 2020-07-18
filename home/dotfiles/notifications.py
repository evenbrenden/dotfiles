#!/usr/bin/python3

import sys
import subprocess

state_path =  '/tmp/dunst-status'
state_on = 'on'
state_off = 'off'

# default state is on
new_state = state_on

# if a valid argument is given then set state to that
if len(sys.argv) == 2 and (sys.argv[1] == state_off or sys.argv[1] == state_on):
    new_state = sys.argv[1]
# if no valid argument is given then toggle the state
elif len(sys.argv) == 1:
    try:
        with open(state_path, 'r') as file:
            contents = file.read()
            old_state = contents.rstrip()
            if old_state == state_on:
                new_state = state_off
            elif old_state == state_off:
                new_state = state_on
    except FileNotFoundError:
        pass

# write to (or create) state file
with open(state_path, 'w') as file:
    file.write(new_state)

# signal new dunst state
if new_state == state_on:
    subprocess.run(['notify-send', 'DUNST_COMMAND_RESUME'], stdout=subprocess.PIPE)
elif new_state == state_off:
    subprocess.run(['notify-send', 'DUNST_COMMAND_PAUSE'], stdout=subprocess.PIPE)

# refresh i3status
subprocess.run(['pkill', '-x', '-USR1', 'i3status'], stdout=subprocess.PIPE)
