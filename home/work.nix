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
    (maven.override { jdk = jdk21; })
    nodejs
    nodePackages.pnpm
    (sbt.override { jre = jdk21; })
    yarn
    xmlformat
  ];
}
