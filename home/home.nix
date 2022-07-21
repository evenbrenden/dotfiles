{ config, pkgs, ... }:

{
  # Dotfiles
  xdg = {
    enable = true;
    configFile = {
      "autorandr".source = ./dotfiles/autorandr;
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
  imports = [ ./bash.nix ./daw.nix ./i3/i3.nix ./vi/vi.nix ];
  programs = {
    home-manager.enable = true;
    man.enable = false;
  };
  home.packages = with pkgs;
    let
      programming = [
        docker-compose
        ghc
        git
        (import ./git-replace.nix { inherit pkgs; })
        graphviz
        python3
        shellcheck
        virtualenv
      ];
      miscellaneous = [
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
        sakura
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
    in programming ++ miscellaneous;

  # Services
  services.dunst = {
    enable = true;
    configFile = ./dotfiles/dunstrc;
  };
  systemd.user.startServices = true;
}
