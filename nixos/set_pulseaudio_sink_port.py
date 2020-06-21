#!/usr/bin/python3

import subprocess

sink_name = 'alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink'
headphones_name = 'Headphones1'
speaker_name = 'Speaker'

output = subprocess.run(['pactl', 'list', 'sinks'], stdout=subprocess.PIPE)
verbose = output.stdout.decode()
sink = verbose.partition(sink_name)[2];
ports = sink.partition('Ports')[2]
headphones = ports.partition(headphones_name)[2]
closed = headphones.splitlines()[0]
available = not 'not available' in closed

file = open('/home/evenbrenden/testfile.txt', 'w')
file.write('Hello World ' + str(available))
file.close()

if available:
    jiggle_port = speaker_name
    target_port = headphones_name
else:
    jiggle_port = headphones_name
    target_port = speaker_name

subprocess.run(['pactl', 'set-sink-port', sink_name, '[Out] ' + jiggle_port], stdout=subprocess.PIPE)
subprocess.run(['pactl', 'set-sink-port', sink_name, '[Out] ' + target_port], stdout=subprocess.PIPE)
