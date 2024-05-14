{ pkgs, ... }:

{
  home.packages = with pkgs; [
    attic-client
    avro-tools
    dbeaver
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    jdk21
    jetbrains.idea-community
    k9s
    kubectl
    nodejs
    nodePackages.pnpm
    sbt
    yarn
    xmlformat
  ];
}
