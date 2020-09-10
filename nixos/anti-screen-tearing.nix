{ lib, ... }:

{
  services.picom = {
    backend = "glx"; # For xsecurelock
    enable = true;
    vSync = false;
  };

  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
