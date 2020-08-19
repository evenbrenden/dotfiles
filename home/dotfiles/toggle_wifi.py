#!/usr/bin/python3

import subprocess

result = subprocess.run(['nmcli', 'radio', 'wifi'], stdout=subprocess.PIPE)
stdout = result.stdout.decode()
state = stdout.rstrip()

if (state == 'enabled'):
    new = 'off'
else:
    new = 'on'
subprocess.run(['nmcli', 'radio', 'wifi', new], stdout=subprocess.PIPE)
