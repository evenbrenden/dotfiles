#!/bin/bash

rm -rf ~/.config/nixpkgs \
    && cp -r home ~/.config/nixpkgs \
    && home-manager switch \
    && i3-msg reload \
    && i3-msg restart
