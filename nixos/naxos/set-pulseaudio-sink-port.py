#! /usr/bin/env python3

import subprocess

sink_name = 'alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi___ucm0001.hw_sofhdadsp__sink'
headphones_name = 'Headphones'
speaker_name = 'Speaker'

output = subprocess.run(['pactl', 'list', 'sinks'], stdout=subprocess.PIPE)
verbose = output.stdout.decode()
sink = verbose.partition(sink_name)[2]
ports = sink.partition('Ports')[2]
headphones = ports.partition(headphones_name)[2]
closed = headphones.splitlines()[0]
available = 'not available' not in closed

if available:
    jiggle_port = speaker_name
    target_port = headphones_name
else:
    jiggle_port = headphones_name
    target_port = speaker_name

subprocess.run(['pactl', 'set-sink-port', sink_name,
               '[Out] ' + jiggle_port], stdout=subprocess.PIPE)
subprocess.run(['pactl', 'set-sink-port', sink_name,
               '[Out] ' + target_port], stdout=subprocess.PIPE)
