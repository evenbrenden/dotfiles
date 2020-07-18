{ config, pkgs, ... }:

{
  imports = [
    ./x1c7_audio_hacks.nix
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
        configurationLimit = 50;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = 524288;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];

  networking = {
    hostName = "naxos";
    networkmanager.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications

  nixpkgs.overlays = [
    (import ../overlays/jetbrains_2019.3.4.nix)
  ];

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  environment = {
    systemPackages = with pkgs; [
      abcde
      alsaTools
      arandr
      autorandr
      brightnessctl
      cabal-install
      chromium
      curl
      dbeaver
      dos2unix
      dotnet-sdk_3
      dunst
      firefox
      fzf
      gimp
      git
      gparted
      hsetroot
      irssi
      jetbrains.rider
      jotta-cli
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
      (callPackage (import ./../pkgs/rclone-sync.nix) {})
      remmina
      sakura
      shellcheck
      slack
      spotify
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

  time.timeZone = "Europe/Amsterdam";

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  services = {
    dbus.socketActivated = true;
    fprintd.enable = true;
    fwupd.enable = true;
    openssh.enable = false;
    picom.enable = true;
    xserver = {
      xautolock = {
        enable = true;
        enableNotifier = true;
        locker = ''${pkgs.i3lock}/bin/i3lock --color 000000'';
        notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in 10s"'';
        notify = 10;
        time = 10;
      };
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
          background = ./nothing.png;
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
