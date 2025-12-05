username:

{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [ "acpi.ec_no_wakeup=1" "amd_pstate=active" ];
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
  ];

  hardware = {
    amdgpu.initrd.enable = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  musnix.enable = true;

  networking.hostName = "labor";

  services = {
    openssh = {
      enable = true;
      extraConfig = builtins.readFile "${pkgs.huddly}/ssh/sshd_config";
    };
    openvpn.servers.work.autoStart = true;
    xserver.videoDrivers = [ "displaylink" "modesetting" ];
  };

  # Waiting for VPN connection
  systemd.services.sshd.serviceConfig = {
    RestartSec = 60;
    StartLimitIntervalSec = 600;
    StartLimitBurst = 10;
  };

  system.stateVersion = "25.05";
}
