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
    azure-cli
    dbeaver
    jetbrains.rider
    kubectl
    kubectx
    postman
    remmina
  ];
}
