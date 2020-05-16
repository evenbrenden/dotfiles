#!/usr/bin/python3

import subprocess

program = 'brightnessctl'
device_argument = '--device=tpacpi::kbd_backlight'

current_output = subprocess.run([program, device_argument, 'get'], stdout=subprocess.PIPE)
current_decoded = current_output.stdout.decode()
current_brightness = int(current_decoded)

max_output = subprocess.run([program, device_argument, 'max'], stdout=subprocess.PIPE)
max_decoded = max_output.stdout.decode()
max_brightness = int(max_decoded)

if (current_brightness > 0):
    new_brightness = 0
else:
    new_brightness = max_brightness

subprocess.run([program, device_argument, 'set', str(new_brightness)], stdout=subprocess.PIPE)
