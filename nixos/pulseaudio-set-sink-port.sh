#!/bin/bash

HEADPHONES='Headphones1'
STATE=$(pactl list sinks | grep "^.*\[Out\] $HEADPHONES: Headphones (.*)$" | sed -e 's/^.*(priority: [0-9]*, \([a-z ]*\))$/\1/')
echo $STATE
if [[ $STATE == "available" ]]; then
    pactl set-sink-port alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink "[Out] $HEADPHONES"
else
    pactl set-sink-port alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink '[Out] Speaker'
fi
