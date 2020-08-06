#!/bin/bash

nixpkgs=$(cat nixpkgs.url)
home-manager -f home/home.nix -I nixpkgs=$nixpkgs switch \
    && i3-msg reload \
    && i3-msg restart
