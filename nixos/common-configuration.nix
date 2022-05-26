{ config, pkgs, ... }:

{
  imports = [ ./display.nix ./screen-locking.nix ];

  # Programs
  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };
  programs.ssh.startAgent = true;
  networking.networkmanager.enable = true;
  services = {
    fprintd.enable = false;
    fwupd.enable = true;
    openssh.enable = false;
  };

  # For Chromecast to work (https://github.com/NixOS/nixpkgs/issues/49630)
  # -With Chromium, run: chromium --load-media-router-component-extension=1
  # -With VLC, temporarily disable firewall: systemctl stop firewall.service
  services.avahi.enable = true; # Needed for Chromium

  # Sound
  hardware = {
    bluetooth.enable = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudio.override { bluetoothSupport = true; };
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };
  nixpkgs.config.pulseaudio =
    true; # Explicit PulseAudio support in applications

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
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

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
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  time.timeZone = "Europe/Amsterdam";
}
