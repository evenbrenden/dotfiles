{ pkgs, ... }:

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
        # hsetroot because xsetroot does not work with Picom
        # Use stars.jpeg behind a not pitch black status bar
        sessionCommands = let
          xresources = pkgs.writeText "Xresources" ''
            Xcursor.theme: Adwaita
            Xcursor.size: 32
          '';
        in ''
          ${pkgs.hsetroot}/bin/hsetroot -tile ${./stars.jpeg}
          ${pkgs.xorg.xrdb}/bin/xrdb -merge <${xresources}
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
