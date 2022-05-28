{ config, pkgs, ... }:

{
  imports = [ ./dotnet.nix ./vscode.nix ];

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
    openapi-generator-cli
    python39Packages.openapi-spec-validator
    postman
  ];
}
