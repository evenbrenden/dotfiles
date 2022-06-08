{ pkgs, lib, ... }:

# This can be moved to home-manager
{
  services = {

    picom = {
      backend = "xr_glx_hybrid"; # For xsecurelock
      enable = true;
      fade =
        false; # https://github.com/google/xsecurelock/issues/97#issuecomment-1100903794
      vSync = true; # Combat screen tearing
    };

    xserver = {
      # Combat screen tearing
      deviceSection = ''
        Option "TearFree" "true"
      '';
      displayManager = {
        defaultSession = "none+i3";
        lightdm = {
          background = "#000000";
          greeters.gtk.indicators =
            [ "~host" "~spacer" "~session" "~language" "~clock" "~power" ];
        };
        # Because xsetroot does not work with Picom
        sessionCommands = ''
          ${pkgs.hsetroot}/bin/hsetroot -solid #000000
        '';
      };
      enable = true;
      extraLayouts.norwerty = {
        description = "Norwerty";
        languages = [ "no" ];
        symbolsFile = ./norwerty/norwerty;
      };
      layout = "us";
      libinput = {
        enable = true;
        touchpad.tapping = true;
      };
      windowManager.i3.enable = true;
    };
  };
}
