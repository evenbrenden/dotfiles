#!/bin/bash

sudo nixos-rebuild -I nixos-config=nixos/configuration.nix -I nixpkgs=../my-nixpkgs switch
