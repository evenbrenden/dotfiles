{ config, pkgs, ... }:

let
  userName = "evenbrenden";
  hostName = "naxos";
in {
  imports = [
    ../common-configuration.nix
    ../laptop-alsa-state.nix
    (import ../../nixos/virtualisation.nix { userName = userName; })
    ./hardware-configuration.nix
    ./x1c7-audio-hacks.nix
  ];

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = [ pkgs.steam-run ];

  # User
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  networking.hostName = "${hostName}";

  # X
  services.xserver = {
    dpi = 144;
    displayManager.autoLogin = {
      enable = true;
      user = "${userName}";
    };
  };

  # Disk and boot
  boot = {
    initrd.luks.devices.root = {
      device = "/dev/nvme0n1p1";
      allowDiscards = true;
      preLVM = true;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
    };
  };
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  system.stateVersion = "20.03";
}
