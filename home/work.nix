{ pkgs, ... }:

{
  home.packages = with pkgs; [
    attic-client
    avro-tools
    dbeaver-bin
    (unstable.google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
    jdk21
    jetbrains.idea-community
    k9s
    kubectl
    (maven.override { jdk_headless = jdk21_headless; })
    nodejs
    nodePackages.pnpm
    openssl
    (sbt.override { jre = jdk21; })
    yarn
    xmlformat
  ];
}
