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
    ./yubikey.nix
    ./hardware-configuration.nix
  ];

  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  networking = {
    hostName = "${hostname}";
    hosts = {
      "10.227.2.5" = [
        "lkc-19xox3-000b-europe-north1-c-gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000b.europe-north1-c.gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000d-europe-north1-c-gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000d.europe-north1-c.gje0qo.europe-north1.gcp.glb.confluent.cloud"
      ];
      "10.227.2.6" = [
        "lkc-19xox3-000e-europe-north1-b-gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000e.europe-north1-b.gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000c-europe-north1-b-gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000c.europe-north1-b.gje0qo.europe-north1.gcp.glb.confluent.cloud"
      ];
      "10.227.2.7" = [
        "lkc-19xox3-gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-0010-europe-north1-a-gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-0010.europe-north1-a.gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000f-europe-north1-a-gje0qo.europe-north1.gcp.glb.confluent.cloud"
        "lkc-19xox3-000f.europe-north1-a.gje0qo.europe-north1.gcp.glb.confluent.cloud"
      ];
      "127.0.0.1" = [ "local.finn.no" "local.tori.fi" ];
    };
  };
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "${username}";
  };

  # Services
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
    opengl = {
      driSupport = lib.mkDefault true;
      driSupport32Bit = lib.mkDefault true;
      extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" "displaylink" ];

  # Misc
  system.stateVersion = "22.05";
}
