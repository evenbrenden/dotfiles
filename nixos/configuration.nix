{ config, pkgs, ... }:

{
  imports = [
    ./x1c7-audio-hacks.nix
    ./power-management.nix
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.luks.devices = {
      root = {
        device = "/dev/nvme0n1p1";
        allowDiscards = true;
        preLVM = true;
      };
    };
    kernel.sysctl."fs.inotify.max_user_watches" = 524288;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
    };
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

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };

  nixpkgs.overlays = [
    (import ../overlays/jetbrains_2019.3.4.nix)
  ];

  environment = {
    systemPackages = with pkgs; [
      abcde
      alsaTools
      arandr
      autorandr
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
      jq
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
      zip
    ];
  };

  programs.ssh.startAgent = true;

  virtualisation.virtualbox.host = {
    enableExtensionPack = true;
    enable = true;
  };

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  time.timeZone = "Europe/Amsterdam";

  services = {
    dbus.socketActivated = true;
    fprintd.enable = true;
    fwupd.enable = true;
    openssh.enable = false;
    picom.enable = true;

    xserver = {
      enable = true;
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
      dpi = 144;
      layout = "us";
      libinput = {
        enable = true;
        tapping = true;
      };
      windowManager.i3.enable = true;
    };
  };

  system.stateVersion = "20.03";
}
