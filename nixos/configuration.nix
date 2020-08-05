{ config, pkgs, ... }:

{
  imports = [
    ./x1c7-audio-hacks.nix
    ./power-management.nix
    ./hardware-configuration.nix
  ];

  # Source
  nix.nixPath =
    let
      pinnedNixpkgs = builtins.fetchTarball {
        name = "nixos-unstable-a45f68ccac+93764";
        url = "https://github.com/evenbrenden/nixpkgs/archive/f09922704bbf84a5a064f38d15caca4fd34419d1.tar.gz";
        sha256 = "01sz92hq0rg4f1lmn97bqn2bd435aac1ryfj6qpk1lpk5wr3sr9a";
      };
    in
      [ "nixpkgs=${pinnedNixpkgs}" ];

  # Programs
  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };
  environment = {
    systemPackages = with pkgs; [
      abcde
      alsaTools
      arandr
      cabal-install
      chromium
      curl
      dbeaver
      dos2unix
      dotnet-sdk_3
      firefox
      flameshot
      fzf
      gimp
      git
      gparted
      hsetroot
      irssi
      jetbrains.rider
      jotta-cli
      jq
      libsForQt5.vlc
      nomacs
      postman
      python3
      python37Packages.virtualenv
      rclone
      (callPackage (import ./../pkgs/rclone-sync.nix) {})
      remmina
      shellcheck
      slack
      spotify
      teams
      transmission-gtk
      unzip
      veracrypt
      vscode
      xorg.xdpyinfo
      zip
    ];
  };
  programs.ssh.startAgent = true;
  services.openssh.enable = false;
  services.fprintd.enable = false;
  services.fwupd.enable = true;
  services.picom.enable = true;
  virtualisation.virtualbox.host = {
    enableExtensionPack = true;
    enable = true;
  };
  networking.networkmanager.enable = true;

  # User
  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  # Display et al.
  services = {
    xserver = {
      enable = true;
      dpi = 144;
      layout = "us";
      displayManager = {
        defaultSession = "none+i3";
        autoLogin.enable = true;
        autoLogin.user = "evenbrenden";
        lightdm = {
          background = ./nothing.png;
          greeters.gtk.indicators = [ "~host" "~spacer" "~session" "~language" "~clock" "~power" ];
        };
        # Because xsetroot does not work with Picom
        sessionCommands = ''
          hsetroot -solid #000000
        '';
      };
      libinput = {
        enable = true;
        tapping = true;
      };
      windowManager.i3.enable = true;
    };
  };

  # Sound
  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications

  # Disk and the likes
  boot = {
    initrd.luks.devices = {
      root = {
        device = "/dev/nvme0n1p1";
        allowDiscards = true;
        preLVM = true;
      };
    };
    kernel.sysctl."fs.inotify.max_user_watches" = 524288;
    kernelPackages = pkgs.linuxPackages_5_7;
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

  # Misc
  networking.hostName = "naxos";
  services.dbus.socketActivated = true;
  system.stateVersion = "20.03";
  time.timeZone = "Europe/Amsterdam";
}

