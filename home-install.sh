#!/bin/bash

home-manager -f home/home.nix switch \
    && i3-msg reload \
    && i3-msg restart
