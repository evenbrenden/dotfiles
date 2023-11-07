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

  # Programs
  environment.systemPackages = with pkgs; [
    avro-tools
    dbeaver
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    jdk
    jetbrains.idea-community
    k9s
    kubectl
    nodejs
    nodePackages.pnpm
    postman
    sbt
    vault
    yarn
    xmlformat
  ];
  programs.appgate-sdp.enable = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  networking = {
    hostName = "${hostname}";
    hosts = { "127.0.0.1" = [ "local.finn.no" ]; };
  };
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "${username}";
  };

  # Services
  services = {
    # Run sudo freshclam once to update the database
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
    fstrim.enable = lib.mkDefault true;
    gnome.gnome-keyring.enable = true; # For Appgate SDP
  };

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
