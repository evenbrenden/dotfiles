{ config, lib, pkgs, ... }:

let
  username = "evenbrenden";
  hostname = "work";
in {
  imports = [
    ../common-configuration.nix
    (import ../dpi.nix {
      inherit pkgs;
      dpi = 120;
    })
    (import ../virtualisation.nix {
      inherit pkgs;
      inherit username;
    })
    ./hardware-configuration.nix
    ./yubikey.nix
  ];

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

  # Services
  services.fprintd.enable = true;
  services.fstrim.enable = lib.mkDefault true;

  # Boot and hardware
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
  hardware = {
    graphics = {
      enable32Bit = lib.mkDefault true;
      extraPackages = with pkgs; [ amdvlk rocmPackages.clr ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" "displaylink" ];

  # Misc
  system.stateVersion = "22.05";
}
