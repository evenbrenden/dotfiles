#!/usr/bin/python3

import sys
import time
import subprocess

delay_seconds = 1
error_msg = 'On or off?'

if (len(sys.argv) != 2):
    print(error_msg)
    sys.exit(1)

what = sys.argv[1]
delay_ms = delay_seconds * 1000

if (what == 'on'):
    subprocess.run(['notify-send', 'DUNST_COMMAND_RESUME'], stdout=subprocess.PIPE)
    subprocess.run(['notify-send', 'Mas på', '--expire-time', str(delay_ms)], stdout=subprocess.PIPE)
elif (what == 'off'):
    subprocess.run(['notify-send', 'Mas av', '--expire-time', str(delay_ms)], stdout=subprocess.PIPE)
    time.sleep(delay_seconds)
    subprocess.run(['notify-send', 'DUNST_COMMAND_PAUSE'], stdout=subprocess.PIPE)
else:
    print(error_msg)
