#!/bin/bash
nixos-rebuild -I nixos-config=nixos/configuration.nix -I nixpkgs=../nixpkgs switch
