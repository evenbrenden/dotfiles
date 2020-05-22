#!/bin/bash

rm -rf ~/.config/nixpkgs \
    && cp -r nixpkgs ~/.config/ \
    && home-manager switch \
    && i3-msg reload \
    && i3-msg restart
