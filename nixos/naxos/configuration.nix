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
  # If a program that needs exclusive ALSA access to an external audio card,
  # just disable that interface for PulseAudio and use the internal audio card
  # for other programs (could use JACK to get around this, won't bother atm).

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
