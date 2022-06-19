{ config, pkgs, ... }:

{
  # Dotfiles
  xdg = {
    enable = true;
    configFile = {
      "autorandr".source = ./dotfiles/autorandr;
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
    "bin/git-prompt.sh".source = ./dotfiles/bin/git-prompt.sh;
    "bin/i3status.sh".source = ./dotfiles/bin/i3status.sh;
    "bin/toggle_keyboard_layout.sh".source =
      ./dotfiles/bin/toggle_keyboard_layout.sh;
    "bin/toggle_wifi.sh".source = ./dotfiles/bin/toggle_wifi.sh;
  };

  # Programs
  imports = [ ./daw.nix ./vi/vi.nix ./work/work.nix ];
  nixpkgs.overlays = [ (import ./discord.nix) ];
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
        xrandr-invert-colors
      ];
      programming = [
        cabal-install
        ghc
        ghcid
        git
        (import ./git-replace.nix { inherit pkgs; })
        graphviz
        haskellPackages.implicit-hie
        hlint
        python3
        shellcheck
        virtualenv
      ];
      user-programs = [
        abcde
        arandr
        audacity
        chromium
        colorpicker
        curl
        discord
        dos2unix
        firefox
        fff
        flac
        flameshot
        fzf
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
  services.dunst = {
    enable = true;
    configFile = ./dotfiles/dunstrc;
  };
  systemd.user.startServices = true;
}
