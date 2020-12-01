{ config, pkgs, ... }:

{
  imports = [
    ../home-common.nix
    ../dotnet.nix
  ];

  nixpkgs.overlays = [
    # JetBrains releases Rider quite often (so nixpkgs is usually behind)
    (import ../../overlays/jetbrains.rider.nix)
  ];

  home.packages = with pkgs; [
    dbeaver
    jetbrains.rider
    postman
    remmina
  ];

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}
