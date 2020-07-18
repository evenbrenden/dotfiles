#!/usr/bin/env python3

import sys
import os
import subprocess
import fileinput

remote = 'gdrive'

local_path = os.getcwd()
user = os.getlogin()
base_path = '/home/' + user + '/' + remote + '/'
split = local_path.partition(base_path)
relative = split[-1]
remote_path = remote + ':' + relative

output = subprocess.run(['rclone', 'check', remote_path, local_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout = output.stdout.decode()
stderr = output.stderr.decode()
print(stdout)
print(stderr)

if '0 differences found' in stderr:
    exit(0)

while True:
    sys.stdout.write('Sync up or down? ')
    sys.stdout.flush()
    inputed = input()
    answer = inputed.rstrip()

    if answer == 'up':
        print()
        subprocess.run(['rclone', 'sync', '--create-empty-src-dirs', '--verbose', local_path, remote_path], stdout=subprocess.PIPE)
        exit(0)
    elif answer == 'down':
        print()
        subprocess.run(['rclone', 'sync', '--create-empty-src-dirs', '--verbose', remote_path, local_path], stdout=subprocess.PIPE)
        exit(0)

