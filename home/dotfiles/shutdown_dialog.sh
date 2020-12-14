#!/usr/bin/env sh

Q="Shut it down?"
NO="No"
YES="Yes"

while [ "$select" != "$NO" -a "$select" != "$YES" ]; do
    select=$(echo -e "$NO\n$YES" | dmenu -i -p "$Q")
    [ -z "$select" ] && exit 0
done
[ "$select" = "$NO" ] && exit 0
i3-msg exec shutdown now
