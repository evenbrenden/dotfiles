{ config, pkgs, ... }:

{
  imports = [ ../home-common.nix ];

  nixpkgs.overlays = [
    (import ../../overlays/jetbrains.rider.nix)
  ];

  home.packages = with pkgs;
    [
      # For dotfiles
      autorandr
      brightnessctl
      dunst
      networkmanagerapplet
      libnotify
      playerctl

      # User programs
      abcde
      arandr
      cabal-install
      chromium
      dos2unix
      firefox
      flameshot
      fzf
      gimp
      gparted
      irssi
      jetbrains.rider
      jotta-cli
      jq
      libsForQt5.vlc
      nomacs
      pavucontrol
      python3
      python37Packages.virtualenv
      (callPackage (import ../../pkgs/rclone-sync.nix) {})
      shellcheck
      slack
      snes9x-gtk
      spotify
      teams
      transmission-gtk
      veracrypt
      vscode
    ];

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}