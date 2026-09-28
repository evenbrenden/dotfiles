username:

{ pkgs, ... }:

{
  boot = {
    initrd.luks.devices.root = {
      allowDiscards = true;
      device = "/dev/nvme0n1p1";
      preLVM = true;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 50;
        enable = true;
      };
    };
  };

  imports = [
    (import ../common-configuration.nix { inherit pkgs username; })
    (import ../dpi.nix {
      dpi = 144;
      inherit pkgs;
    })
    ./hardware-configuration.nix
    ./x1c7-audio-hacks.nix
  ];

  musnix.enable = true;

  networking.hostName = "naxos";

  services = {
    openssh.enable = false;
    xserver.videoDrivers = [ "displaylink" ];
  };

  system.stateVersion = "20.03";
}
