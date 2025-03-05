username:

{ pkgs, ... }:

{
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
    (import ../common-configuration.nix { inherit pkgs username; })
    (import ../dpi.nix {
      dpi = 144;
      inherit pkgs;
    })
    ./hardware-configuration.nix
    ./steam.nix
    ./x1c7-audio-hacks.nix
  ];

  musnix.enable = true;

  networking.hostName = "naxos";

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
}
