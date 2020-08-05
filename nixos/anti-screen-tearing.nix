{ lib, ... }:

{
  services.picom = {
    enable = true;
    vSync = false;
  };
  services.xserver = {
    videoDrivers = lib.mkDefault [ "intel" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
