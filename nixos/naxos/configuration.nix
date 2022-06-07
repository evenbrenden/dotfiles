{ config, pkgs, ... }:

let
  userName = "evenbrenden";
  hostName = "naxos";
in {
  imports = [
    ../common-configuration.nix
    ./laptop-alsa-state.nix
    ./x1c7-audio-hacks.nix
    ./hardware-configuration.nix
  ];

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = [ pkgs.steam-run ];

  # User
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
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

  # VM
  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enableExtensionPack = true;
      enable = true;
    };
  };

  # Disk
  boot.initrd.luks.devices.root = {
    device = "/dev/nvme0n1p1";
    allowDiscards = true;
    preLVM = true;
  };

  system.stateVersion = "20.03";
}
