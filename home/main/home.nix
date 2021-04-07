{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
    ../dotnet.nix
  ];

  nixpkgs.overlays = [
    (import ../../overlays/jetbrains.rider.nix)
  ];

  home.packages = with pkgs; [
    azure-cli
    dbeaver
    jetbrains.rider
    kubectl
    kubectx
    postman
    remmina
  ];
}
