{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
  ];

  # This is only so that dmenu is able to list programs that are installed with Nix
  programs.bash.enable = true; # So that session variables are sourced in ~/.profile
  targets.genericLinux.enable = true; # So that Nix profile is added to XDG_DATA_DIRS
}
