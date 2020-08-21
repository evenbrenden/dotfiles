{ lib, ... }:

{
  services.picom = {
    backend = "glx"; # For xsecurelock
    enable = true;
    vSync = false;
    settings.paint-on-overlay = true;
  };

  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
