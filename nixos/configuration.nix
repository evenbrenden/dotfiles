{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
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
  hardware.pulseaudio = {
    enable = true;
    # Need this for sof-hda-dsp until PulseAudio 14
    extraConfig = ''
        load-module module-alsa-sink device=hw:0,0 channels=4
        load-module module-alsa-source device=hw:0,6 channels=4
    '';
  };
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications

  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
    chromium.enableWideVine = true;
  };

  environment = {
    systemPackages = with pkgs; [
      abcde
      arandr
      autorandr
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
      postman
      python3
      python37Packages.virtualenv
      rclone
      remmina
      sakura
      shellcheck
      slack
      spotify
      unstable.dotnet-sdk_3
      unstable.jotta-cli
      unstable.teams
      unzip
      veracrypt
      virtualboxWithExtpack
      vscode
      xorg.xdpyinfo
    ];
  };

  programs.ssh.startAgent = true;

  nix.gc.automatic = true;
  nix.gc.dates = "04:00";

  time.timeZone = "Europe/Amsterdam";

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  services.acpid = {
    enable = true;
    handlers = {
      headphonesIn = {
        event = "jack/headphone HEADPHONE plug";
        action = ''
            /run/current-system/sw/bin/amixer -q -c 0 set 'Bass Speaker' off
        '';
      };
      headphonesOut = {
        event = "jack/headphone HEADPHONE unplug";
        action = ''
            /run/current-system/sw/bin/amixer -q -c 0 set 'Bass Speaker' on
        '';
      };
    };
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
