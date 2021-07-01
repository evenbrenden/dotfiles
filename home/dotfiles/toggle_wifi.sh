#!/usr/bin/env bash

state=$(nmcli radio wifi)

if [[ $state == 'enabled' ]]; then
    nmcli radio wifi off
else
    nmcli radio wifi on
fi
