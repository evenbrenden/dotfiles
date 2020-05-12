#!/usr/bin/python3

#import sys
import subprocess

subprocess.run(['amixer', '-q', '-c', '0', 'set', 'Master', 'toggle'], stdout=subprocess.PIPE)
subprocess.run(['pkill', '-x', '-USR1', 'i3status'], stdout=subprocess.PIPE)
