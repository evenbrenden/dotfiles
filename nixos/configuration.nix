{ config, pkgs, ... }:

let
  dunst_bleeding = pkgs.dunst.overrideAttrs (oldAttrs: rec {
    src = pkgs.fetchFromGitHub {
      owner = "dunst-project";
      repo = "dunst";
      rev = "fd4a4dbc9c13eae19bbd46ef52e1fca56aa0a3d9";
      sha256 = "09xssjl038kh00hafygzbsk4ahgzhx2p5a626j19z60a57vvf4j9";
    };
  });
in
{
  imports = [
    ./x1c7-audio-hacks.nix
    ./power-management.nix
    ./hardware-configuration.nix
  ];

  # Programs
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
      dunst_bleeding
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
  services.openssh.enable = false;
  services.fprintd.enable = true;
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

  # Misc
  networking.hostName = "naxos";
  services.dbus.socketActivated = true;
  system.stateVersion = "20.03";
  time.timeZone = "Europe/Amsterdam";
}

