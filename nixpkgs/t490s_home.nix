{ config, pkgs, ... }:

{
  imports = [
    ./common_home.nix
  ];

  home.file."toggle_mute.py".source = ./dotfiles/t490s_toggle_mute.py;
}
