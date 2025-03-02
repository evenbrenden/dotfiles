{ pkgs, ... }:

{
  services = {
    libinput = {
      enable = true;
      touchpad.tapping = true;
    };

    xserver.xkb.extraLayouts.norwerty = let norwerty = import ./norwerty/norwerty.nix { inherit pkgs; };
    in {
      description = "Norwerty";
      languages = [ "no" ];
      symbolsFile = "${norwerty}/share/X11/xkb/symbols/norwerty";
    };
  };
}
