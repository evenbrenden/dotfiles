#! /usr/bin/env python3

import subprocess

sink_name: str = 'alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi___ucm0001.hw_sofhdadsp__sink'
headphones_name: str = 'Headphones'
speaker_name: str = 'Speaker'

output = subprocess.check_output(['pactl', 'list', 'sinks'])
verbose: str = output.decode('utf-8')
sink: str = verbose.partition(sink_name)[2]
ports: str = sink.partition('Ports')[2]
headphones: str = ports.partition(headphones_name)[2]
closed: str = headphones.splitlines()[0]
available: bool = 'not available' not in closed

if available:
    jiggle_port: str = speaker_name
    target_port: str = headphones_name
else:
    jiggle_port = headphones_name
    target_port = speaker_name

subprocess.run(['pactl', 'set-sink-port', sink_name,
               '[Out] ' + jiggle_port], stdout=subprocess.PIPE)
subprocess.run(['pactl', 'set-sink-port', sink_name,
               '[Out] ' + target_port], stdout=subprocess.PIPE)
