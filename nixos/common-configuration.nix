{ config, pkgs, ... }:

{
  imports = [
    ./power-management.nix
    ./anti-screen-tearing.nix
  ];

  # Programs
  nixpkgs.overlays = [
    # Skipping i3wm 4.18.2 (https://github.com/i3/i3/issues/4159)
    (import ../overlays/i3wm.nix)
  ];
  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };
  programs.ssh.startAgent = true;
  services.openssh.enable = false;
  services.fprintd.enable = false;
  services.fwupd.enable = true;
  virtualisation.virtualbox.host = {
    enableExtensionPack = true;
    enable = true;
  };
  networking.networkmanager.enable = true;

  # For Chromecast to work (https://github.com/NixOS/nixpkgs/issues/49630)
  # -With Chromium, run: chromium --load-media-router-component-extension=1
  # -With VLC, temporarily disable firewall: systemctl stop firewall.service
  services.avahi.enable = true; # Needed for Chromium

  # Display et al.
  services = {
    xserver = {
      enable = true;
      dpi = 144;
      layout = "us";
      displayManager = {
        defaultSession = "none+i3";
        lightdm = {
          background = ./nothing.png;
          greeters.gtk.indicators = [ "~host" "~spacer" "~session" "~language" "~clock" "~power" ];
        };
        # Because xsetroot does not work with Picom
        sessionCommands = ''
          ${pkgs.hsetroot}/bin/hsetroot -solid #000000
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
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudio.override {
      bluetoothSupport = true;
    };
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };
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
  fonts = {
    enableDefaultFonts = true;
    fontconfig.allowBitmaps = false; # Fixes some blocky fonts in Firefox
  };
  networking.firewall.enable = true;
  services.dbus.socketActivated = true;
  system.stateVersion = "20.03";
  time.timeZone = "Europe/Amsterdam";
}
