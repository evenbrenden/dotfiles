#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo 'home-install [nixos/generic-linux]'
    exit 1
fi

config="home/host-types/$1.nix"
if [[ ! -f $config ]]; then
    echo "$config not found"
    exit 1
fi

nixpkgs=$(cat home-nixpkgs.url)
home-manager -f $config -I nixpkgs=$nixpkgs switch &&
    i3-msg reload &&
    i3-msg restart
