{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices = {
      root = {
        device = "/dev/nvme0n1p1";
        preLVM = true;
        allowDiscards = true;
      };
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 120;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  networking = {
    hostName = "naxos";
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
    networkmanager.enable = true;
    useDHCP = false;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications

  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  nixpkgs.overlays = [
    (import ../overlays/pulseaudio.nix)
    (import ../overlays/jetbrains_old.nix)
  ];

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  environment = {
    systemPackages = with pkgs; [
      abcde
      arandr
      autorandr
      brightnessctl
      cabal-install
      chromium
      curl
      dbeaver
      dos2unix
      dunst
      firefox
      gimp
      git
      gparted
      hsetroot
      irssi
      jetbrains.rider
      networkmanagerapplet
      libnotify
      libsForQt5.vlc
      linuxConsoleTools
      nomacs
      playerctl
      postman
      python3
      python37Packages.virtualenv
      rclone
      remmina
      sakura
      shellcheck
      slack
      spotify
      dotnet-sdk_3
      jotta-cli
      teams
      unzip
      veracrypt
      vscode
      xorg.xdpyinfo
    ];
  };

  virtualisation.virtualbox.host = {
    enableExtensionPack = true;
    enable = true;
  };

  programs.ssh.startAgent = true;

  nix.gc.automatic = true;
  nix.gc.dates = "04:00";

  time.timeZone = "Europe/Amsterdam";

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  services = {
    dbus.socketActivated = true;
    openssh.enable = false;
    picom.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      dpi = 144;
      libinput = {
        enable = true;
        tapping = true;
      };
      displayManager = {
        defaultSession = "none+i3";
        lightdm = {
          autoLogin.enable = true;
          autoLogin.user = "evenbrenden";
          background = "#000000";
          greeters.gtk.indicators = [ "~host" "~spacer" "~session" "~language" "~clock" "~power" ];
        };
        # Because xsetroot does not work with Picom
        sessionCommands = ''
            hsetroot -solid #000000
        '';
      };
      windowManager.i3.enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
    };
  };

  system.stateVersion = "20.03";
}
