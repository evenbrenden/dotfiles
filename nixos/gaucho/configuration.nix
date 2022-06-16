{ config, pkgs, ... }:

let
  username = "evenbrenden";
  hostName = "gaucho";
in {
  imports =
    [ ../common-configuration.nix ./hardware-configuration.nix ./musnix ];

  # DAW
  musnix.enable = true;

  # Internal sound card quirk (NB! Requires that the USB card is connected)
  hardware.pulseaudio.extraConfig = ''
    set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo
    set-card-profile alsa_card.usb-Focusrite_Scarlett_8i6_USB_00007200-00 off
  '';

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = [ pkgs.steam-run ];

  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };
  networking.hostName = "${hostName}";

  # X
  services.xserver = {
    dpi = 120;
    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
  };

  # Disk and boot
  boot = {
    initrd.luks.devices.root = {
      device = "/dev/sda1";
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

  system.stateVersion = "20.09";
}
