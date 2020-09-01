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

nixpkgs='https://github.com/NixOS/nixpkgs/archive/f9567594d5af2926a9d5b96ae3bada707280bec6.tar.gz'
home-manager -f $config -I nixpkgs=$nixpkgs switch \
    && i3-msg reload \
    && i3-msg restart
