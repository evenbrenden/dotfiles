{ config, pkgs, ... }:

{
  imports = [
    ../home-common.nix
    ./vscode.nix
  ];

  nixpkgs.overlays = [
    # JetBrains releases Rider quite often (so nixpkgs is usually behind)
    (import ../../overlays/jetbrains.rider.nix)
    # Waiting for 0.7.33634 (https://github.com/jotta/jotta-cli-issues/issues/111)
    (import ../../overlays/jotta-cli.nix)
  ];

  home.packages = with pkgs; [
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
    graphviz
    irssi
    jetbrains.rider
    jotta-cli
    jq
    vlc
    nomacs
    pavucontrol
    python3
    python37Packages.virtualenv
    (callPackage (import ../../pkgs/rclone-sync) {})
    shellcheck
    slack
    snes9x-gtk
    spotify
    teams
    transmission-gtk
    udiskie
    veracrypt
  ];

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}
