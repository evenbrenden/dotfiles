#!/usr/bin/python3

import sys
import subprocess
import re

output = subprocess.run(['setxkbmap', '-query'], stdout=subprocess.PIPE)
verbose = output.stdout.decode()
pattern = re.compile('layout:[\s]+(.*)\n')
match = pattern.search(verbose)
layout = match.group(1)

if (layout == 'us'):
    new = 'no'
else:
    new = 'us'
subprocess.run(['setxkbmap', '-layout', new], stdout=subprocess.PIPE)
# https://forum.manjaro.org/t/i3-unable-to-force-i3status-refresh-with-killall/27730
subprocess.run(['pkill', '-x', '-USR1', 'i3status'], stdout=subprocess.PIPE)
