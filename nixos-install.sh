#!/usr/bin/env bash

nixpkgs=$(cat nixpkgs.url)
sudo nixos-rebuild -I nixos-config=nixos/configuration.nix -I nixpkgs=$nixpkgs switch
