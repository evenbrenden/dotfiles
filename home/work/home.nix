{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
    ./dotnet.nix
    ./vscode.nix
  ];

  nixpkgs.overlays = [
    (import ./jetbrains.rider.nix)
  ];

  home.packages = with pkgs; [
    azure-cli
    cifs-utils
    dbeaver
    docker-compose
    freerdp
    inetutils
    jetbrains.rider
    kubectl
    kubectx
    kubelogin
    postman
  ];
}
