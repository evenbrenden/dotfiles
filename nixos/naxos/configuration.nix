{ config, pkgs, ... }:

let
  username = "evenbrenden";
  hostname = "naxos";
in {
  imports = [
    ../common-configuration.nix
    (import ../dpi.nix {
      inherit pkgs;
      dpi = 144;
    })
    ../laptop-alsa-state.nix
    (import ../virtualisation.nix {
      inherit pkgs;
      inherit username;
    })
    ./hardware-configuration.nix
    ./x1c7-audio-hacks.nix
  ];
  nixpkgs.overlays = [
    (self: super: {
      sof-firmware = with super;
        import ./sof-firmware.nix {
          inherit fetchurl;
          inherit lib;
          inherit stdenvNoCC;
        };
    })
  ];

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = [ pkgs.steam-run ];

  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };
  networking.hostName = "${hostname}";
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "${username}";
  };

  # Disk and boot
  boot = {
    initrd.luks.devices.root = {
      device = "/dev/nvme0n1p1";
      allowDiscards = true;
      preLVM = true;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
    };
  };

  system.stateVersion = "20.03";
}
