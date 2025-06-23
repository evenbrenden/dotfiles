username:

{ config, pkgs, ... }:

{
  # TODO: Merge with generated configuration.nix

  # boot = {
  #   initrd.luks.devices.root = {
  #     allowDiscards = true;
  #     device = "/dev/nvme0n1p1";
  #     preLVM = true;
  #   };
  #   loader = {
  #     efi.canTouchEfiVariables = true;
  #     systemd-boot = {
  #       configurationLimit = 50;
  #       enable = true;
  #     };
  #   };
  # };

  boot.kernelParams = [ "acpi.ec_no_wakeup=1" "amd_pstate=active" ];

  imports = [
    (import ../common-configuration.nix { inherit pkgs username; })
    (import ../dpi.nix {
      dpi = 144;
      inherit pkgs;
    })
    # ./hardware-configuration.nix
  ];

  hardware = {
    amdgpu.initrd.enable = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  musnix.enable = true;

  networking.hostName = "labor";

  services.xserver.videoDrivers = [ "modesetting" ];
  # services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # system.stateVersion = "25.05";
}
