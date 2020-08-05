#!/bin/bash

# Using nixpkgs #93764 rebased on a45f68ccac (while waiting for it to be merged)
sudo nixos-rebuild -I nixos-config=nixos/configuration.nix -I nixpkgs=../my-nixpkgs switch
