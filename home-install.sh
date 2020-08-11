#!/bin/bash

nixpkgs=$(cat nixpkgs.url)
home-manager -f home/home-$1.nix -I nixpkgs=$nixpkgs switch \
    && i3-msg reload \
    && i3-msg restart
