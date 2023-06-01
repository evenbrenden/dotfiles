{ pkgs, dpi }:

{
  services.xserver = {
    displayManager = {
      sessionCommands = let
        xresources = pkgs.writeText "Xresources" ''
          Xft.dpi: ${toString dpi}
        '';
      in ''
        ${pkgs.xorg.xrdb}/bin/xrdb -merge <${xresources}
      '';
    };
    dpi = dpi;
  };
}
