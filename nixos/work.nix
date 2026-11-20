{ pkgs, ... }:

{
  security.pam.services.login.enableGnomeKeyring = true;

  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };
  systemd.tmpfiles.rules = [ "L+ /bin/bash - - - - /run/current-system/sw/bin/bash" ];
}
