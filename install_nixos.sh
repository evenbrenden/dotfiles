#!/bin/bash

cp nixos/configuration.nix /etc/nixos/configuration.nix \
    && nixos-rebuild switch
