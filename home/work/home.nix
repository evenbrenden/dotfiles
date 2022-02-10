{ config, pkgs, ... }:

{
  imports = [ ../common-home.nix ./dotnet.nix ];

  nixpkgs.overlays = [ (import ./jetbrains.rider.nix) ];

  home.packages = with pkgs; [
    azure-cli
    cifs-utils
    dbeaver
    docker-compose
    (import ./fantomasify.nix { inherit pkgs; })
    freerdp
    inetutils
    jetbrains.rider
    kubectl
    kubectx
    kubelogin
    postman
  ];
}
