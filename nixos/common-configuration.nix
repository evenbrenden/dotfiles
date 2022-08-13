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
  };
  nixpkgs.config.pulseaudio =
    true; # Explicit PulseAudio support in applications

  # Disk and boot
  boot = {
    kernel.sysctl."fs.inotify.max_user_watches" = 524288;
    supportedFilesystems = [ "ntfs" ];
  };

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
  hardware.video.hidpi.enable = true;
  networking.firewall.enable = true;
  nix = {
    # Binary cache for haskell.nix
    binaryCachePublicKeys =
      [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
    binaryCaches = [ "https://cache.iog.io" ];
    # Enable flakes
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  time.timeZone = "Europe/Amsterdam";
  users.users.root.initialHashedPassword =
    "$6$v.fIgZCsq1yKDoVm$LZqzWgHJk9BmP3tmOhyVPsVbMhQzzAEOluMe6cV37YvYEPZwU0yIiH1i9lG1L9f68CyY9TXMfzfHV81X80RGR1";
}
