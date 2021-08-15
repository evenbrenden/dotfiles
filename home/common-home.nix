{ config, pkgs, ... }:

{
  # Programs
  imports = [
    (import ./neovim.nix)
  ];
  nixpkgs.overlays = [
    (import ./jotta-cli.nix)
    (import ./signal-desktop.nix)
  ];
  programs = {
    home-manager.enable = true;
    man.enable = false;
  };
  home.packages = with pkgs;
    [
      # For dotfiles
      autorandr
      brightnessctl
      dunst # For dunstctl
      libnotify
      playerctl
      sakura

      # User programs
      abcde
      arandr
      audacity
      cabal-install
      chromium
      curl
      dos2unix
      firefox
      fff
      flac
      flameshot
      fzf
      ghostwriter
      gimp
      git
      gparted
      graphviz
      irssi
      jotta-cli
      jq
      libreoffice
      nomacs
      p7zip
      pandoc
      pavucontrol
      python3
      python37Packages.virtualenv
      rclone
      shellcheck
      signal-desktop
      slack
      smartmontools
      snes9x-gtk
      spotify
      standardnotes
      teams
      transmission-gtk
      veracrypt
      vlc
      xclip
    ];

  # Services
  services = {
    dunst.enable = true;
    network-manager-applet.enable = true;
  };
  systemd.user.startServices = true;

  # Actual dotfiles (not managed home-manager style)
  xdg = {
    enable = true;
    configFile = {
      "autorandr".source = ./dotfiles/autorandr;
      "dunst/dunstrc".source = ./dotfiles/dunstrc;
      "ghostwriter/ghostwriter.conf".source = ./dotfiles/ghostwriter.conf;
      "i3/config".source = ./dotfiles/i3config;
      "i3status/config".source = ./dotfiles/i3status;
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
    };
  };
  home.file = {
    ".abcde.conf".source = ./dotfiles/abcde.conf;
    ".bashrc".text = builtins.readFile ./dotfiles/bashrc; # .text => file is being prepended/appended to elsewhere
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
    "bin/toggle_keyboard_layout.sh".source = ./dotfiles/toggle_keyboard_layout.sh;
    "bin/toggle_wifi.sh".source = ./dotfiles/toggle_wifi.sh;
  };
}
