{ config, pkgs, ... }:

let
  userName = SET_MANUALLY;
  hostName = SET_MANUALLY;
{
  imports = [
    ./common-configuration.nix
    ./t490s-hardware-configuration.nix
  ];

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  networking.hostName = ${hostName};
}
