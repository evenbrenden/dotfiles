{ config, pkgs, ... }:

{
  environment.sessionVariables.XKB_CONFIG_ROOT =
    config.services.xserver.xkb.dir; # Because services.xserver.xkb.extraLayouts does it
  services.xserver.xkb.dir = "${pkgs.xkeyboardconfig-norwerty}/etc/X11/xkb";
}
