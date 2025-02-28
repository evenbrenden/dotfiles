{ ... }:

{
  services = {

    displayManager.defaultSession = "none+i3";

    # This can be moved to home-manager
    picom = {
      backend = "xr_glx_hybrid"; # For xsecurelock
      enable = true;
      fade = false; # https://github.com/google/xsecurelock/issues/97#issuecomment-1100903794
      vSync = true; # Combat screen tearing
    };

    xserver = {
      # Combat screen tearing
      deviceSection = ''
        Option "TearFree" "true"
      '';

      enable = true;

      # This can be moved to home-manager
      windowManager.i3.enable = true;
    };
  };
}
