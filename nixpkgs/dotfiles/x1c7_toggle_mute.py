#!/usr/bin/python3

import subprocess
subprocess.run(['pactl', 'set-sink-mute', '@DEFAULT_SINK@', 'toggle'], stdout=subprocess.PIPE)
subprocess.run(['pkill', '-x', '-USR1', 'i3status'], stdout=subprocess.PIPE)
