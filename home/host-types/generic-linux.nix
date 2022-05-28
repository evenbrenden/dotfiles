{ config, pkgs, ... }:

{
  imports = [ ../common-home.nix ];

  # So that dmenu is able to list programs that are installed with Nix
  targets.genericLinux.enable =
    true; # So that Nix profile is added to XDG_DATA_DIRS
}
