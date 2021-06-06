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

  # Internal sound card quirk (NB! Requires that the USB card is connected)
  hardware.pulseaudio.extraConfig = ''
    set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo
    set-card-profile alsa_card.usb-Focusrite_Scarlett_8i6_USB_00007200-00 off
  '';

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
