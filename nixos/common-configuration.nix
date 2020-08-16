{ config, pkgs, ... }:

{
  imports = [
    ./power-management.nix
    ./anti-screen-tearing.nix
  ];

  # Programs
  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };
  environment.systemPackages = with pkgs;
    [
      alsaTools
      hsetroot
    ];
  programs.ssh.startAgent = true;
  services.openssh.enable = false;
  services.fprintd.enable = false;
  services.fwupd.enable = true;
  virtualisation.virtualbox.host = {
    enableExtensionPack = true;
    enable = true;
  };
  networking.networkmanager.enable = true;

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
  services.dbus.socketActivated = true;
  system.stateVersion = "20.03";
  time.timeZone = "Europe/Amsterdam";
}
