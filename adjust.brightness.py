#!/usr/bin/python3

import sys
import subprocess
import re

if (len(sys.argv) != 2):
    print("Up or down?")
    sys.exit(1)

screen = 'eDP-1'
step = 0.1
updown = sys.argv[1]

if (updown != 'up' and updown != 'down'):
    print("Up or down?")
    sys.exit(1)

output = subprocess.run(['xrandr', '--verbose'], stdout=subprocess.PIPE)
verbose = output.stdout.decode()
pattern = re.compile("Brightness: (.*)\n") # Assuming it's the only one
match = pattern.search(verbose)
result = match.group(1)
brightness = float(result)

if (updown == 'up'):
    adjusted = brightness + step
elif (updown == 'down'):
    adjusted = brightness - step
if (adjusted >= 0 and adjusted <= 1):
    subprocess.run(['xrandr', '--output', screen, '--brightness', str(adjusted)], stdout=subprocess.PIPE)
