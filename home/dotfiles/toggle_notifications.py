#!/usr/bin/python3

import sys
import subprocess

output = subprocess.run(['dunstctl', 'running'], stdout=subprocess.PIPE)
state = output.stdout.decode().rstrip()

if (state == 'true'):
    subprocess.run(['dunstctl', 'set-running', 'false'], stdout=subprocess.PIPE)
elif (state == 'false'):
    subprocess.run(['dunstctl', 'set-running', 'true'], stdout=subprocess.PIPE)

subprocess.run(['pkill', '-x', '-USR1', 'i3status'], stdout=subprocess.PIPE)
