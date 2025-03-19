{ config, pkgs, sops-nix, username, ... }:

{
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./emote.nix
    ./fonts.nix
    ./git.nix
    ./i3.nix
    ./screen-locking.nix
    sops-nix
    ./ssh.nix
    ./studio.nix
    ./vi/vi.nix
    ./work.nix
  ];

  home = {
    file = {
      ".abcde.conf".source = ./dotfiles/abcde.conf;
      ".aider.conf.yml".source = ./dotfiles/aider.conf.yml;
      ".ghci".source = ./dotfiles/ghci;
      ".prettierrc".source = ./dotfiles/prettierrc;
      ".ssr/settings.conf".source = ./dotfiles/ssr.conf;
    };
    homeDirectory = "/home/${config.home.username}";
    keyboard.layout = "us";
    packages = with pkgs;
      let
        programming = [
          unstable.aider-chat
          docker-compose
          fourmolu-all
          ghc
          graphviz
          haskellPackages.cabal-fmt
          hurl
          mypy
          nixfmt-all
          python3
          shellcheck
        ];
      in [
        abcde
        age
        alsa-utils
        arandr
        audacity
        chromium
        curl
        unstable.discord
        dos2unix
        file
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
        libnotify
        libreoffice
        nomacs
        okular
        p7zip
        pandoc
        pavucontrol
        rclone
        unstable.signal-desktop
        simplescreenrecorder
        slack
        snes9x-gtk
        sops
        transmission_4-gtk
        tree
        unstable.veracrypt
        vlc
        whatsapp-for-linux
        xclip
        xcolor
        x-www-browser
      ] ++ programming;
    stateVersion = "22.05";
    username = username;
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home-manager.enable = true;
    man.enable = false;
  };

  services = {
    dunst = {
      configFile = ./dotfiles/dunstrc;
      enable = true;
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
    parcellite = {
      enable = true;
      extraOptions = [ "--no-icon" ];
    };
    picom = {
      backend = "glx";
      enable = true;
      # https://github.com/google/xsecurelock/issues/97#issuecomment-1183086902
      fadeExclude = [ "class_g = 'xsecurelock'" ];
      vSync = true;
    };
  };

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt"; # Need this or will silently fail
    defaultSopsFile = ../secrets/secrets.yaml;
    secrets = {
      codeberg-org-private-key.path = "${config.home.homeDirectory}/.ssh/codeberg-org-private-key";
      github-com-private-key.path = "${config.home.homeDirectory}/.ssh/github-com-private-key";
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

  xdg = {
    configFile = {
      "autorandr/postswitch".source = pkgs.lib.getExe (pkgs.writeShellApplication {
        name = "autorandr-postswitch";
        runtimeInputs = with pkgs; [ refresh-wallpaper systemd ];
        text = ''
          refresh-wallpaper
          systemctl --user restart dunst.service
          systemctl --user restart parcellite.service
        '';
      });
      "fourmolu.yaml".source = ./dotfiles/fourmolu.yaml;
      "kde.org/ghostwriter.conf".source = ./dotfiles/ghostwriter.conf;
      "nixpkgs/config.nix".source = ./dotfiles/nixpkgs-config.nix;
      "parcellite/parcelliterc".source = ./dotfiles/parcelliterc;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
      "VeraCrypt/Favorite Volumes.xml".source = ./dotfiles/veracrypt-favorite-volumes.xml;
    };
    enable = true;
    mimeApps = {
      defaultApplications = {
        "application/pdf" = [ "okularApplication_pdf.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "audio/flac" = [ "vlc.desktop" ];
        "audio/mp4" = [ "vlc.desktop" ];
        "audio/mpeg" = [ "vlc.desktop" ];
        "audio/x-aiff" = [ "vlc.desktop" ];
        "audio/x-wav" = [ "vlc.desktop" ];
        "image/gif" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/jpeg" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/png" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/svg+xml" = [ "org.nomacs.ImageLounge.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" "appgate.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/magnet" = [ "transmission-gtk.desktop" ];
        "x-scheme-handler/msteams" = [ "teams.desktop" ];
        "x-scheme-handler/unknown" = [ "firefox.desktop" "appgate.desktop" ];
      };
      enable = true;
    };
  };

  xresources.extraConfig = ''
    Xcursor.size: 48
    Xcursor.theme: Adwaita
    XTerm*faceName: DejaVu Sans Mono
    XTerm*faceSize: 12
  '';

  xsession.enable = true;
}
