#!/bin/bash
rm -rf ~/.config/nixpkgs \
    && cp -r nixpkgs ~/.config/ \
    && mv ~/.config/nixpkgs/x1c7_home.nix ~/.config/nixpkgs/home.nix \
    && home-manager switch \
    && i3-msg reload \
    && i3-msg restart
