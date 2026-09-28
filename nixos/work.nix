{ pkgs, username, ... }:

{
  services = {
    openvpn.servers.mobile = {
      autoStart = false;
      config = "config /home/${username}/openvpn/mobile.ovpn";
      updateResolvConf = true;
    };
    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
    };
  };

  systemd.tmpfiles.rules = [ "L+ /bin/bash - - - - /run/current-system/sw/bin/bash" ];
}
