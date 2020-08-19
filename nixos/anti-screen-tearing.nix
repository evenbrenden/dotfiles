{ lib, ... }:

{
  services.picom = {
    backend = "glx";
    enable = true;
    vSync = false;
  };
  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
