#!/usr/bin/env bash

ARCHIVE=Diva_144_9775_Linux.tar.xz
if [[ ! -f $ARCHIVE ]]; then
    echo "$ARCHIVE is missing"
    exit 1
fi

tar -xvf $ARCHIVE -C /tmp
mkdir -p ~/.u-he
cp -r /tmp/Diva-9775/Diva ~/.u-he
rm ~/.u-he/Diva/Diva*.so
rm ~/.u-he/Diva/dialog*
rm -rf /tmp/Diva-9775
