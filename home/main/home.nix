{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
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
}
