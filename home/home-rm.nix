{ config, pkgs, ... }:

{
  imports = [ ./home-common.nix ];

  home.packages = with pkgs;
    [
      autorandr
      brightnessctl
      dunst
      networkmanagerapplet
      libnotify
      playerctl
    ];


  xdg.configFile."i3/config".text = with builtins;
    (readFile ./dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config-rm);
}
