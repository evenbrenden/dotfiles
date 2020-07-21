#!/usr/bin/env bash

while [ "$select" != "No" -a "$select" != "Yes" ]; do
    select=$(echo -e 'No\nYes' | dmenu -i -p "Shut down?")
    [ -z "$select" ] && exit 0
done
[ "$select" = "No" ] && exit 0
i3-msg exec shutdown now
