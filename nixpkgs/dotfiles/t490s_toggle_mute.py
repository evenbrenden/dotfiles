#!/usr/bin/python3

import subprocess

subprocess.run(['amixer', '-q', '-D', 'pulse', 'set', 'Master', 'toggle'], stdout=subprocess.PIPE)
subprocess.run(['pkill', '-x', '-USR1', 'i3status'], stdout=subprocess.PIPE)
