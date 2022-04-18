{ lib, ... }:

{
  services.picom = {
    backend = "xr_glx_hybrid"; # For xsecurelock
    enable = true;
    fade =
      false; # https://github.com/google/xsecurelock/issues/97#issuecomment-1100903794
    vSync = true;
  };

  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
