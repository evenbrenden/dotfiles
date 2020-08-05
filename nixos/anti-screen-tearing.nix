{ lib, ... }:

{
  services.picom = {
    enable = true;
    vSync = false;
  };
  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
