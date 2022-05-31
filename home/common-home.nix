{ config, pkgs, ... }:

{
  # Dotfiles
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
    ".ghci".source = ./dotfiles/ghci;
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    ".ssr/settings.conf".source = ./dotfiles/ssr.conf;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
    "bin/toggle_keyboard_layout.sh".source =
      ./dotfiles/toggle_keyboard_layout.sh;
    "bin/toggle_wifi.sh".source = ./dotfiles/toggle_wifi.sh;
  };

  # Programs
  imports = [ ./daw/daw.nix ./vi/vi.nix ./work/work.nix ];
  nixpkgs.overlays = [ (import ./discord.nix) (import ./signal-desktop.nix) ];
  programs = {
    bash = {
      enable = true;
      initExtra = builtins.readFile ./dotfiles/bashrc;
      shellOptions = [ ]; # Set in initExtra
    };
    home-manager.enable = true;
    man.enable = false;
  };
  home.packages = with pkgs;
    let
      for-dotfiles = [
        autorandr
        brightnessctl
        dunst # For dunstctl
        libnotify
        playerctl
        sakura
      ];
      programming = [
        cabal-install
        ghc
        ghcid
        git
        git-crypt
        (import ./git-replace.nix { inherit pkgs; })
        graphviz
        haskellPackages.implicit-hie
        hlint
        python3
        python37Packages.virtualenv
        shellcheck
      ];
      user-programs = [
        abcde
        arandr
        audacity
        chromium
        curl
        discord
        dos2unix
        firefox
        fff
        flac
        flameshot
        fzf
        ghostwriter
        gimp
        gparted
        irssi
        jq
        libheif
        libreoffice
        nomacs
        okular
        p7zip
        pandoc
        pavucontrol
        rclone
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
    in for-dotfiles ++ programming ++ user-programs;

  # Services
  services.dunst.enable = true;
  systemd.user.startServices = true;
}
