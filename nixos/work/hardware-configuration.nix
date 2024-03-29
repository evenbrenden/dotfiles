# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4c7d0a3a-3ecb-4777-9594-7cddf32e2fcd";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-fc815a66-2763-4a12-9429-3bed09885225".device =
    "/dev/disk/by-uuid/fc815a66-2763-4a12-9429-3bed09885225";

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/7E94-BAF4";
    fsType = "vfat";
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/a51feed8-9609-4f78-bfaf-886af1044473"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.bnep0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
