{ config, pkgs, ... }:

{
  # Dotfiles
  home.file = {
    ".abcde.conf".source = ./dotfiles/abcde.conf;
    ".ghci".source = ./dotfiles/ghci;
    ".ssr/settings.conf".source = ./dotfiles/ssr.conf;
  };
  xdg = {
    enable = true;
    configFile = {
      "autorandr".source = ./dotfiles/autorandr;
      "fourmolu.yaml".source = ./dotfiles/fourmolu.yaml;
      "ghostwriter/ghostwriter.conf".source = ./dotfiles/ghostwriter.conf;
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
      "VeraCrypt/Favorite Volumes.xml".source =
        ./dotfiles/veracrypt-favorite-volumes.xml;
    };
  };

  # Programs
  imports = [
    ./bash.nix
    ./daw.nix
    ./git.nix
    ./i3/i3.nix
    ./mimeapps.nix
    ./parcellite.nix
    ./vi/vi.nix
  ];
  nixpkgs.overlays = with pkgs; [
    (import ./discord.nix)
    # https://github.com/NixOS/nixpkgs/pull/182069#issuecomment-1213432500
    (self: super: {
      firefox = super.firefox.overrideAttrs (old: {
        libs = old.libs + ":" + lib.makeLibraryPath [ pkgs.nss_latest ];
      });
    })
    (import ./metals.nix)
  ];
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
    man.enable = false;
    vscode = {
      enable = true;
      mutableExtensionsDir = true;
    };
  };
  home.packages = with pkgs;
    let
      programming =
        [ docker-compose ghc graphviz python3 shellcheck virtualenv ];
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
        sakura
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
    in programming ++ miscellaneous;

  # Services
  disabledModules = [ "services/parcellite.nix" ];
  services = {
    dunst = {
      enable = true;
      configFile = ./dotfiles/dunstrc;
    };
    flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };
    # Ctrl+Alt+H
    parcellite = {
      enable = true;
      extraOptions = [ "--no-icon" ];
    };
  };
  systemd.user = {
    startServices = true;
    # https://github.com/nix-community/home-manager/issues/2064#issuecomment-887300055
    targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };

  # Misc
  nixpkgs.config.allowUnfree = true;
}
