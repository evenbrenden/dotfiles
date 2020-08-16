#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo 'nixos-install [x1c7|t490s]'
    exit 1
fi

nixpkgs=$(cat nixpkgs.url)
sudo nixos-rebuild -I nixos-config=nixos/$1-configuration.nix -I nixpkgs=$nixpkgs switch
