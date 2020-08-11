{ config, pkgs, ... }:

{
  imports = [ ./home-common.nix ];

  xdg.configFile."i3/config".source = ./dotfiles/i3config-vm;
}
