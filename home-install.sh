#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo 'home-install [machine]'
    exit 1
fi

config="home/$1/home.nix"
if [[ ! -f $config ]]; then
    echo "$config not found"
    exit 1;
fi

nixpkgs=$(cat nixpkgs-home.url)
home-manager -f $config -I nixpkgs=$nixpkgs switch \
    && i3-msg reload \
    && i3-msg restart
