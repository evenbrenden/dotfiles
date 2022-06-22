{ config, pkgs, ... }:

{
  # Dotfiles
  xdg = {
    enable = true;
    configFile = {
      "autorandr".source = ./dotfiles/autorandr;
      "i3/config".source = ./dotfiles/i3/config;
      "i3status/config".source = ./dotfiles/i3/statusconfig;
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
  };

  # Programs
  imports = [ ./daw.nix ./vi/vi.nix ./work/work.nix ];
  nixpkgs.overlays = [ (import ./discord.nix) ];
  programs = {
    bash = {
      enable = true;
      initExtra = builtins.concatStringsSep "\n" [
        "source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh"
        (builtins.readFile ./dotfiles/bashrc)
      ];
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
        git # For git-prompt.sh
        (import ./dotfiles/i3/i3quo.nix { inherit pkgs; })
        libnotify
        playerctl
        sakura
        (import ./dotfiles/i3/toggle_keyboard_layout.nix { inherit pkgs; })
        (import ./dotfiles/i3/toggle_wifi.nix { inherit pkgs; })
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
        (callPackage ./standardnotes.nix { })
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
