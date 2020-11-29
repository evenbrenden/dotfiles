{ config, pkgs, ... }:

let
  renoisePath = ./rns_324_linux_x86_64.tar.gz;
  hasRenoise = builtins.pathExists renoisePath;
in
{
  imports = [
    ../home-common.nix
    ./vscode.nix
  ];

  nixpkgs.overlays = [
    # JetBrains releases Rider quite often (so nixpkgs is usually behind)
    (import ../../overlays/jetbrains.rider.nix)
    # Waiting for 0.8.36055 (https://github.com/jotta/jotta-cli-issues/issues/111)
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

    # DAW
    ardour
  ]
  ++
  (
    lib.lists.optional
    hasRenoise
    (renoise.override { releasePath = renoisePath; })
  );

  # Terrible workaround until I can figure out how to make the desktop item
  # supplied with the Renoise tarball to work when installed via the package
  xdg.dataFile =
    pkgs.lib.attrsets.optionalAttrs
    hasRenoise
    { "applications/renoise.desktop".source = ./renoise.desktop; };

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}
