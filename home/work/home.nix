{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
    ./dotnet.nix
  ];

  nixpkgs.overlays = [
    (import ./jetbrains.rider.nix)
  ];

  home.packages = with pkgs; [
    azure-cli
    dbeaver
    docker-compose
    inetutils
    jetbrains.rider
    kubectl
    kubectx
    lastpass-cli
    postman
    remmina
  ];
}
