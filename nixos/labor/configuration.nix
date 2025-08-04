username:

{ config, pkgs, ... }:

{
  boot = {
    initrd.luks.devices."luks-2a9364d3-6cfa-4600-bd32-6b55da1eb4f2".device =
      "/dev/disk/by-uuid/2a9364d3-6cfa-4600-bd32-6b55da1eb4f2";
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 50;
        enable = true;
      };
    };
  };

  boot.kernelParams = [ "acpi.ec_no_wakeup=1" "amd_pstate=active" ];

  imports = [
    (import ../common-configuration.nix { inherit pkgs username; })
    (import ../dpi.nix {
      dpi = 144;
      inherit pkgs;
    })
    ./hardware-configuration.nix
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

  services = {
    openvpn.servers.huddly = {
      config = "config /root/nixos/openvpn/oslo_office_vpn_evenbrenden.ovpn";
      updateResolvConf = true;
    };
    xserver.videoDrivers = [ "displaylink" "modesetting" ];
  };

  system.stateVersion = "25.05";
}
