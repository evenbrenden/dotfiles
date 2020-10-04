{ lib, ... }:

{
  services.picom = {
    backend = "xr_glx_hybrid"; # For xsecurelock
    enable = true;
    vSync = false;
  };

  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
