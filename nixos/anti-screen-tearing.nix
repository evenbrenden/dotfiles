{ lib, ... }:

{
  services.picom = {
    backend = "xr_glx_hybrid"; # For xsecurelock
    enable = true;
    vSync = true;
  };

  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
