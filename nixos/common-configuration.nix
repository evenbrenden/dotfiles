{ pkgs, username, ... }:

{
  boot = {
    tmp.cleanOnBoot = true;
    kernel.sysctl."fs.inotify.max_user_watches" = 524288;
    supportedFilesystems = [ "ntfs" ];
  };

  environment.systemPackages = with pkgs; [ lshw pciutils ]; # Debug WLAN

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  imports = [
    ./bluetooth.nix
    (import ./virtualisation.nix {
      inherit pkgs;
      inherit username;
    })
    ./xkb.nix
  ];

  networking = {
    firewall.enable = true;
    networkmanager.enable = true;
  };

  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "${username}";
      };
      defaultSession = "none+home-manager";
    };
    fprintd.enable = true;
    fwupd.enable = true;
    gnome.at-spi2-core.enable = true; # https://github.com/NixOS/nixpkgs/issues/16327
    libinput = {
      enable = true;
      touchpad.tapping = true;
    };
    logind.lidSwitch = "ignore";
    openssh.enable = false;
    pipewire.enable = false;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudio.override { bluetoothSupport = true; };
    };
    upower = {
      criticalPowerAction = "PowerOff";
      enable = true;
    };
    xserver = {
      # Note that these sessions are started via xsession-wrapper which increments SHLVL
      # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/11
      displayManager.session = [{
        manage = "window";
        name = "home-manager";
        start = ''
          ${pkgs.runtimeShell} $HOME/.xsession &
          waitPID=$!
        '';
      }];
      deviceSection = ''
        Option "TearFree" "true"
      '';
      enable = true;
    };
  };

  time.timeZone = "Europe/Amsterdam";

  users.users = {
    ${username} = {
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
      isNormalUser = true;
    };
    root.initialHashedPassword =
      "$6$v.fIgZCsq1yKDoVm$LZqzWgHJk9BmP3tmOhyVPsVbMhQzzAEOluMe6cV37YvYEPZwU0yIiH1i9lG1L9f68CyY9TXMfzfHV81X80RGR1";
  };
}
