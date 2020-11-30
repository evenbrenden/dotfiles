{ config, pkgs, ... }:

let
  userName = "evenbrenden";
  hostName = "gaucho";
in
{
  imports = [
    ../common-configuration.nix
    ./musnix
  ];

  # DAW
  musnix.enable = true;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ];
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "${userName}";
  };

  networking.hostName = "${hostName}";
}
