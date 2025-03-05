{ pkgs, ... }:

let
  username = "evenbrenden";
  hostname = "naxos";
in {
  boot = {
    initrd.luks.devices.root = {
      allowDiscards = true;
      device = "/dev/nvme0n1p1";
      preLVM = true;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 50;
        enable = true;
      };
    };
  };

  imports = [
    ../common-configuration.nix
    (import ../dpi.nix {
      dpi = 144;
      inherit pkgs;
    })
    ./hardware-configuration.nix
    ./steam.nix
    (import ../virtualisation.nix {
      inherit pkgs;
      inherit username;
    })
    ./x1c7-audio-hacks.nix
  ];

  musnix.enable = true;

  networking.hostName = "${hostname}";

  services = {
    displayManager.autoLogin = {
      enable = true;
      user = "${username}";
    };
  };

  system.stateVersion = "20.03";

  systemd.services = {
    auto-mute-mode = {
      description = "Set Auto-Mute Mode";
      script = ''
        amixer -c 0 set 'Auto-Mute Mode' 'Disabled'
      '';
      path = [ pkgs.alsa-utils ];
      after = [ "multi-user.target" "sound.target" "graphical.target" ];
      wantedBy = [ "sound.target" ];
    };
  };

  users.users.${username} = {
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    isNormalUser = true;
  };
}
