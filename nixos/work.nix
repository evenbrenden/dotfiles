{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [ cacert ];

  networking.firewall.allowedUDPPorts = [
    42105 # falconpyclient
    50124 # falconpyclient
  ];

  programs.nix-ld.enable = true;

  services = {
    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
    };
    openvpn.servers.mobile = {
      autoStart = false;
      config = "config /home/${username}/openvpn/mobile.ovpn";
      updateResolvConf = true;
    };
    udev.packages = let
      huddly-udev-rules = pkgs.stdenv.mkDerivation {
        name = "huddly-udev-rules";
        src = pkgs.huddly;
        installPhase = ''
          mkdir -p $out/lib/udev/rules.d
          cp $src/udev/* $out/lib/udev/rules.d/
        '';
      };
    in [ huddly-udev-rules ];
  };

  systemd.tmpfiles.rules = [ "L+ /bin/bash - - - - /run/current-system/sw/bin/bash" ];

  users = {
    groups.plugdev = { };
    users.${username}.extraGroups = [ "plugdev" ]; # udev
  };
}
