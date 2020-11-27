{ config, pkgs, ... }:

let
  userName = "evenbrenden";
  hostName = "naxos";
in
{
  imports = [
    ../common-configuration.nix
    ./x1c7-audio-hacks.nix
    ./x1c7-hardware-configuration.nix
    ./musnix
  ];

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # DAW
  musnix.enable = true;
  environment.systemPackages = with pkgs;
    (lib.lists.optional
    (builtins.pathExists ./Diva_144_9775_Linux.tar.xz)
    (callPackage ./u-he-diva.nix {}));
  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback.enable = true;
  };

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" "jackaudio" ];
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "${userName}";
  };

  networking.hostName = "${hostName}";
}
