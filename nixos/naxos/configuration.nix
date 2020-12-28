{ config, pkgs, ... }:

let
  userName = "evenbrenden";
  hostName = "naxos";
in
{
  imports = [
    ../common-configuration.nix
    ./x1c7-audio-hacks.nix
    ./hardware-configuration.nix
  ];

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;
  environment.systemPackages = [ pkgs.steam-run ];

  # User
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };
  networking.hostName = "${hostName}";

  # X
  services.xserver = {
    dpi = 144;
    displayManager.autoLogin = {
      enable = true;
      user = "${userName}";
    };
  };

  # VM
  virtualisation.virtualbox.host = {
    enableExtensionPack = true;
    enable = true;
  };

  # Sound
  system.activationScripts.asound = ''
    ${pkgs.alsaUtils}/bin/amixer -q -c 0 set 'Mic Mute-LED Mode' 'Follow Mute'
    ${pkgs.alsaUtils}/bin/amixer -q -c 0 set 'Auto-Mute Mode' 'Disabled'
  '';

  # Disk
  boot.initrd.luks.devices.root = {
    device = "/dev/nvme0n1p1";
    allowDiscards = true;
    preLVM = true;
  };

  system.stateVersion = "20.03";
}
