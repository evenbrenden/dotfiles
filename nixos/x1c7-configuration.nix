{ config, pkgs, ... }:

{
  imports = [
    ./common-configuration.nix
    ./x1c7-audio-hacks.nix
    ./x1c7-hardware-configuration.nix
  ];

  users.users.evenbrenden = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "evenbrenden";
  };

  networking.hostName = "naxos";
}
