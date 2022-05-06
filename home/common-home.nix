{ config, pkgs, ... }:

{
  # Programs
  imports = [ ./vi/vi.nix ];
  nixpkgs.overlays = [
    (import ./discord.nix)
    (import ./signal-desktop.nix)
  ];
  programs = {
    home-manager.enable = true;
    man.enable = false;
  };
  home.packages = with pkgs; [
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
    haskellPackages.brittany
    cabal-install
    chromium
    curl
    discord
    dos2unix
    firefox
    fff
    flac
    flameshot
    fzf
    ghc
    ghcid
    ghostwriter
    gimp
    git
    (import ./git-replace.nix { inherit pkgs; })
    gparted
    graphviz
    haskellPackages.implicit-hie # gen-hie
    hlint
    irssi
    jq
    libheif
    libreoffice
    nixfmt
    nomacs
    okular
    p7zip
    pandoc
    pavucontrol
    python3
    python37Packages.virtualenv
    rclone
    ripgrep # For fzf
    shellcheck
    signal-desktop
    simplescreenrecorder
    slack
    smartmontools
    snes9x-gtk
    spotify
    standardnotes
    teams
    transmission-gtk
    tree
    veracrypt
    vlc
    whatsapp-for-linux
    xclip
  ];

  # Services
  services.dunst.enable = true;
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
      "VeraCrypt/Favorite Volumes.xml".source =
        ./dotfiles/veracrypt-favorite-volumes.xml;
    };
  };
  home.file = {
    ".abcde.conf".source = ./dotfiles/abcde.conf;
    ".bashrc".text = builtins.readFile
      ./dotfiles/bashrc; # .text => file is being prepended/appended to elsewhere
    ".ghci".source = ./dotfiles/ghci;
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    ".ssr/settings.conf".source = ./dotfiles/ssr.conf;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
    "bin/toggle_keyboard_layout.sh".source =
      ./dotfiles/toggle_keyboard_layout.sh;
    "bin/toggle_wifi.sh".source = ./dotfiles/toggle_wifi.sh;
  };
}
