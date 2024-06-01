{ pkgs, ... }:

let
  username = "evenbrenden";
  hostname = "gaucho";
in {
  imports = [
    ../common-configuration.nix
    (import ../dpi.nix {
      inherit pkgs;
      dpi = 120;
    })
    ./hardware-configuration.nix
  ];

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
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  networking.hostName = "${hostname}";
  services.displayManager.autoLogin = {
    enable = true;
    user = "${username}";
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
