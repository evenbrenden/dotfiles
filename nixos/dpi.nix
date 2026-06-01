{ dpi, pkgs }:

{
  services.xserver = {
    displayManager.sessionCommands =
      let
        xresources = pkgs.writeText "Xresources" ''
          Xft.dpi: ${toString dpi}
        '';
      in
      ''
        ${pkgs.xrdb}/bin/xrdb -merge <${xresources}
      '';
    dpi = dpi;
  };
}
