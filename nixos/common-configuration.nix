{ pkgs, ... }:

{
  imports = [ ./chromecast.nix ./display.nix ./keyboard-and-mouse.nix ./sound.nix ./work.nix ];

  # Programs
  networking.networkmanager.enable = true;
  services = {
    fwupd.enable = true;
    gnome = {
      at-spi2-core.enable = true; # https://github.com/NixOS/nixpkgs/issues/16327
      gnome-keyring.enable = true; # For Appgate SDP
    };
    openssh.enable = false;
    udisks2.enable = true;
  };
  programs.appgate-sdp.enable = true;
  environment.systemPackages = with pkgs; [ lshw pciutils ]; # Debug WLAN

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
