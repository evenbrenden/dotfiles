{ config, pkgs, ... }:

{
  environment.sessionVariables.XKB_CONFIG_ROOT = config.services.xserver.xkb.dir;
  services.xserver.xkb.dir = "${pkgs.xorg.xkeyboardconfig-norwerty}/etc/X11/xkb";
}
