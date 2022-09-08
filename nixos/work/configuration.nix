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
    (unstable.google-cloud-sdk.withExtraComponents
      [ unstable.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    kubectl
    nodejs
  ];
  programs.appgate-sdp.enable = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  networking.hostName = "${hostname}";

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

  # Boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      luks.devices = {
        "luks-274c1723-863d-4437-87e5-2c3a9446fc9d".device =
          "/dev/disk/by-uuid/274c1723-863d-4437-87e5-2c3a9446fc9d";
        "luks-274c1723-863d-4437-87e5-2c3a9446fc9d".keyFile =
          "/crypto_keyfile.bin";
      };
      secrets = { "/crypto_keyfile.bin" = null; };
    };
  };

  # Misc
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "22.05";
}
