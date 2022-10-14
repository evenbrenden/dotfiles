{ config, lib, pkgs, ... }:

let
  username = "evenbrenden";
  hostname = "work";
in {
  imports = [
    ../common-configuration.nix
    (import ../virtualisation.nix { username = username; })
    ./hardware-configuration.nix
  ];

  # Programs
  environment.systemPackages = with pkgs; [
    dbeaver
    (unstable.google-cloud-sdk.withExtraComponents
      [ unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    jdk
    jetbrains.idea-community
    k9s
    kubectl
    sbt
    vault
    yarn
    yubioath-desktop
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

  # Services
  services = {
    clamav.daemon.enable = true;
    fstrim.enable = lib.mkDefault true;
    gnome.gnome-keyring.enable = true; # For Appgate SDP
    xserver = {
      displayManager.autoLogin = {
        enable = true;
        user = "${username}";
      };
      dpi = 120;
    };
  };

  # Boot and hardware
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    kernelModules = [ "acpi_call" "amdgpu" ];
    # For mainline support of rtw89 wireless networking
    kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.16")
      pkgs.linuxPackages_latest;
    kernelParams = [ "acpi_backlight=native" "mem_sleep_default=deep" ];
    initrd = {
      luks = {
        devices."luks-0d9eb120-e084-40ca-b784-551ddc6de0b5".device =
          "/dev/disk/by-uuid/0d9eb120-e084-40ca-b784-551ddc6de0b5";
        devices."luks-0d9eb120-e084-40ca-b784-551ddc6de0b5".keyFile =
          "/crypto_keyfile.bin";
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
    firmware = [ pkgs.rtw89-firmware ]; # Wireless
    opengl = {
      driSupport = lib.mkDefault true;
      driSupport32Bit = lib.mkDefault true;
      extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Misc
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "22.05";
}
