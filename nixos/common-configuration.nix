{ config, pkgs, ... }:

{
  imports = [
    ./screen-locking.nix
    ./anti-screen-tearing.nix
  ];

  # Programs
  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };
  programs.ssh.startAgent = true;
  services.openssh.enable = false;
  services.fprintd.enable = false;
  services.fwupd.enable = true;
  networking.networkmanager.enable = true;

  # For Chromecast to work (https://github.com/NixOS/nixpkgs/issues/49630)
  # -With Chromium, run: chromium --load-media-router-component-extension=1
  # -With VLC, temporarily disable firewall: systemctl stop firewall.service
  services.avahi.enable = true; # Needed for Chromium

  # Display et al.
  services = {
    xserver = {
      enable = true;
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
        touchpad.tapping = true;
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
    kernel.sysctl."fs.inotify.max_user_watches" = 524288;
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

  # Power management
  services = {
    logind.lidSwitch = "ignore";
    upower = {
      enable = true;
      criticalPowerAction = "PowerOff";
    };
  };

  # Misc
  fonts = {
    enableDefaultFonts = true;
    fontconfig.allowBitmaps = false; # Fixes some blocky fonts in Firefox
  };
  networking.firewall.enable = true;
  time.timeZone = "Europe/Amsterdam";
}
