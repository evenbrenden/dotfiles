{ config, pkgs, ... }:

let
  userName = "evenbrenden";
  hostName = "gaucho";
in
{
  imports = [
    ../common-configuration.nix
    ./hardware-configuration.nix
    ./musnix
  ];

  # DAW
  musnix.enable = true;

  # User
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };
  networking.hostName = "${hostName}";

  # X
  services.xserver = {
    dpi = 96;
    displayManager.autoLogin = {
      enable = true;
      user = "${userName}";
    };
  };

  # Disk
  boot.initrd.luks.devices.root = {
    device = "/dev/sda1";
    allowDiscards = true;
    preLVM = true;
  };

  system.stateVersion = "20.09";
}
