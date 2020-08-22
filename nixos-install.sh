#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo 'nixos-install [machine]'
    exit 1
fi

config="nixos/$1-configuration.nix"
if [[ ! -f $config ]]; then
    echo "$config not found"
    exit 1;
fi

nixpkgs=$(cat nixpkgs.url)
sudo nixos-rebuild -I nixos-config=$config -I nixpkgs=$nixpkgs switch
