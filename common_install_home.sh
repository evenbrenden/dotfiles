#!/bin/bash

if [ $# -ne 1 ]; then
    exit
fi

COMPUTER=$1

rm -rf ~/.config/nixpkgs \
    && cp -r nixpkgs ~/.config/ \
    && mv ~/.config/nixpkgs/${COMPUTER}_home.nix ~/.config/nixpkgs/home.nix \
    && home-manager switch \
    && i3-msg reload \
    && i3-msg restart
