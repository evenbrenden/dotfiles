{ pkgs, ... }:

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

      # This can be moved to home-manager
      displayManager.sessionCommands = let
        xresources = pkgs.writeText "Xresources" ''
          Xcursor.size: 48
          Xcursor.theme: Adwaita
          XTerm*faceName: DejaVu Sans Mono
          XTerm*faceSize: 12
        '';
      in ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge <${xresources}
      '';

      enable = true;

      # This can be moved to home-manager
      windowManager.i3.enable = true;

      xkb = {
        extraLayouts.norwerty = let norwerty = import ./norwerty/norwerty.nix { inherit pkgs; };
        in {
          description = "Norwerty";
          languages = [ "no" ];
          symbolsFile = "${norwerty}/share/X11/xkb/symbols/norwerty";
        };
        # This can be moved to home-manager
        layout = "us";
      };
    };
  };
}
