{ pkgs, ... }:

{
  services = {
    libinput = {
      enable = true;
      touchpad.tapping = true;
    };

    xserver = {
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
