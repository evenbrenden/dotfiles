username:

{ config, lib, pkgs, ... }:

{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    kernelModules = [ "acpi_call" "amdgpu" ];
    kernelParams = [ "acpi_backlight=native" "mem_sleep_default=deep" ];
    initrd = {
      luks = {
        devices."luks-0d9eb120-e084-40ca-b784-551ddc6de0b5".device =
          "/dev/disk/by-uuid/0d9eb120-e084-40ca-b784-551ddc6de0b5";
        devices."luks-0d9eb120-e084-40ca-b784-551ddc6de0b5".keyFile = "/crypto_keyfile.bin";
      };
      secrets = { "/crypto_keyfile.bin" = null; };
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      systemd-boot.enable = true;
    };
  };

  environment.variables.AMD_VULKAN_ICD = lib.mkDefault "RADV";

  imports = [
    (import ../common-configuration.nix { inherit pkgs username; })
    (import ../dpi.nix {
      dpi = 120;
      inherit pkgs;
    })
    ./hardware-configuration.nix
    ./yubikey.nix
  ];

  hardware = {
    graphics = {
      enable32Bit = lib.mkDefault true;
      extraPackages = with pkgs; [ amdvlk rocmPackages.clr ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };

  networking.hostName = "work";

  services = {
    fstrim.enable = lib.mkDefault true;
    xserver.videoDrivers = [ "amdgpu" "displaylink" ];
  };

  system.stateVersion = "22.05";
}
