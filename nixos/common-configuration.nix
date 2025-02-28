{ pkgs, ... }:

{
  imports = [ ./display.nix ./keyboard-and-mouse.nix ./screen-locking.nix ./sound.nix ./work.nix ];

  # Programs
  # This can be moved to home-manager
  programs.ssh.startAgent = true;

  networking.networkmanager.enable = true;
  services = {
    fwupd.enable = true;
    gnome.at-spi2-core.enable = true; # https://github.com/NixOS/nixpkgs/issues/16327

    # This can be moved to home-manager
    gnome.gnome-keyring.enable = true; # For Appgate SDP
    openssh.enable = false;

    udisks2.enable = true;
  };
  programs.appgate-sdp.enable = true;

  # This can be moved to home-manager
  environment.systemPackages = with pkgs; [ lshw pciutils ]; # Debug WLAN

  # For Chromecast to work (https://github.com/NixOS/nixpkgs/issues/49630)
  # -With Chromium, run: chromium --load-media-router-component-extension=1
  # -With VLC, temporarily disable firewall: systemctl stop firewall.service
  services.avahi.enable = true; # Needed for Chromium

  # Disk and boot
  boot = {
    tmp.cleanOnBoot = true;
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

  # AV
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Misc
  environment.pathsToLink = [ "/share/ir" "/share/midi" "/share/sfz" "/share/soundfonts" ];

  # This can be moved to home-manager
  fonts = {
    enableDefaultPackages = true;
    fontconfig.allowBitmaps = false; # Fixes some blocky fonts in Firefox
    packages = [ pkgs.dejavu_fonts ];
  };

  networking.firewall.enable = true;

  # This can be moved to home-manager
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # Binary cache for haskell.nix
    settings = {
      trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
      substituters = [ "https://cache.iog.io" ];
    };
  };
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Amsterdam";
  users.users.root.initialHashedPassword =
    "$6$v.fIgZCsq1yKDoVm$LZqzWgHJk9BmP3tmOhyVPsVbMhQzzAEOluMe6cV37YvYEPZwU0yIiH1i9lG1L9f68CyY9TXMfzfHV81X80RGR1";
}
