{ config, pkgs, ... }:

{
  imports = [ ./home-common.nix ];

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
      curl
      dbeaver
      dos2unix
      firefox
      flameshot
      fzf
      gimp
      git
      irssi
      jetbrains.rider
      jotta-cli
      jq
      libsForQt5.vlc
      nomacs
      pavucontrol
      postman
      python3
      python37Packages.virtualenv
      rclone
      (callPackage (import ../pkgs/rclone-sync.nix) {})
      remmina
      shellcheck
      slack
      snes9x-gtk
      spotify
      teams
      transmission-gtk
      unzip
      veracrypt
      vscode
      zip
    ];

  xdg.configFile."i3/config".text = with builtins;
    (readFile ./dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config-rm);
}
