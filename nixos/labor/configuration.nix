username:

{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [
      "acpi.ec_no_wakeup=1"
      "amd_pstate=active"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 50;
        enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [ cacert ];

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

  networking = {
    firewall = {
      interfaces."tailscale0".allowedTCPPorts = [ 22 ]; # Restrict SSH to Tailscale.
      trustedInterfaces = [ "enp198s0f4u1u1" ]; # DDS + falconpycli
    };
    hostName = "labor";
  };

  programs = {
    nix-ld.enable = true;
    ssh.extraConfig = ''
      Include ${pkgs.huddly}/ssh/smartbase
      Include ${pkgs.huddly}/ssh/ssh_ci_config
      Include ${pkgs.huddly}/ssh/ssh_config
    '';
  };

  services = {
    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
    };
    openssh = {
      enable = true;
      extraConfig = ''
        AuthenticationMethods publickey
      '';
      openFirewall = false; # Restrict SSH to Tailscale.
    };
    udev.packages =
      let
        huddly-udev-rules = pkgs.stdenv.mkDerivation {
          name = "huddly-udev-rules";
          src = pkgs.huddly;
          installPhase = ''
            mkdir -p $out/lib/udev/rules.d
            cp $src/udev/* $out/lib/udev/rules.d/
          '';
        };
      in
      [ huddly-udev-rules ];
    xserver.videoDrivers = [
      "displaylink"
      "modesetting"
    ];
  };

  users = {
    groups.plugdev = { };
    users.${username} = {
      extraGroups = [ "plugdev" ]; # udev
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMp2TAvT6s+flBpn+a2ii8SpRHlWoWjD/JDWJKBaxAjP evenbrenden-work"
      ];
    };
  };

  system.stateVersion = "25.05";
}
