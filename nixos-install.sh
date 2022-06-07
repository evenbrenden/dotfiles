#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo 'nixos-install [machine]'
    exit 1
fi

if [[ $1 == 'work' ]]; then
    config="$1/nixos/configuration.nix"
else
    config="nixos/$1/configuration.nix"
fi

if [[ ! -f $config ]]; then
    echo "$config not found"
    exit 1;
fi

nixpkgs=$(cat nixos-nixpkgs.url)
sudo nixos-rebuild -I nixos-config=$config -I nixpkgs=$nixpkgs switch
