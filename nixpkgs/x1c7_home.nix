{ config, pkgs, ... }:

{
  imports = [
    ./common_home.nix
  ];

  home.file."toggle_mute.py".source = ./dotfiles/x1c7_toggle_mute.py;
}
