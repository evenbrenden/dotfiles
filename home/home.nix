{ config, pkgs, sops-nix, username, ... }:

{
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./clipmenu.nix
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
      ".codex/config.toml".source = ./dotfiles/codex.toml;
      ".codex/AGENTS.md".source = ./dotfiles/AGENTS.md;
      ".ghci".source = ./dotfiles/ghci;
      ".prettierrc".source = ./dotfiles/prettierrc;
      ".ssr/settings.conf".source = ./dotfiles/ssr.conf;
    };
    homeDirectory = "/home/${config.home.username}";
    keyboard.layout = "us";
    packages = with pkgs;
      let
        programming = [
          unstable.aider-chat-with-playwright
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
        cryptsetup
        unstable.discord
        dos2unix
        file
        firefox
        fff
        flac
        kdePackages.ghostwriter
        gimp
        irssi
        jq
        libheif
        libnotify
        libreoffice
        nomacs
        kdePackages.okular
        p7zip
        pandoc
        parted
        pavucontrol
        rclone
        unstable.signal-desktop
        simplescreenrecorder
        slack
        snes9x-gtk
        sops
        sox
        tomb
        transmission_4-gtk
        tree
        vlc
        wasistlos
        xclip
        xcolor
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
    picom = {
      backend = "glx";
      enable = true;
      # https://github.com/google/xsecurelock/issues/97#issuecomment-1183086902
      fadeExclude = [ "class_g = 'xsecurelock'" ];
      vSync = true;
    };
  };

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
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
        runtimeInputs = with pkgs; [ hsetroot systemd ];
        text = ''
          hsetroot -solid '#7A3E9D' # A dark moderate violet
          # Things that need a bump post display changes
          systemctl --user restart dunst.service
        '';
      });
      "fourmolu.yaml".source = ./dotfiles/fourmolu.yaml;
      "kde.org/ghostwriter.conf".source = ./dotfiles/ghostwriter.conf;
      "nixpkgs/config.nix".source = ./dotfiles/nixpkgs-config.nix;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
    };
    enable = true;
    mimeApps = let firefox = "firefox.desktop";
    in {
      defaultApplications = {
        "application/pdf" = [ "okularApplication_pdf.desktop" ];
        "application/x-extension-html" = [ firefox ];
        "audio/flac" = [ "vlc.desktop" ];
        "audio/mp4" = [ "vlc.desktop" ];
        "audio/mpeg" = [ "vlc.desktop" ];
        "audio/x-aiff" = [ "vlc.desktop" ];
        "audio/x-wav" = [ "vlc.desktop" ];
        "image/gif" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/jpeg" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/png" = [ "org.nomacs.ImageLounge.desktop" ];
        "image/svg+xml" = [ "org.nomacs.ImageLounge.desktop" ];
        "text/html" = [ firefox ];
        "x-scheme-handler/about" = [ firefox ];
        "x-scheme-handler/chrome" = [ firefox ];
        "x-scheme-handler/http" = [ firefox ];
        "x-scheme-handler/https" = [ firefox ];
        "x-scheme-handler/magnet" = [ "transmission-gtk.desktop" ];
        "x-scheme-handler/msteams" = [ "teams.desktop" ];
        "x-scheme-handler/unknown" = [ firefox ];
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
