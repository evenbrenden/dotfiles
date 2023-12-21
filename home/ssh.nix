{ config, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "codeberg.org".identityFile = "${config.sops.secrets.codeberg-private-key.path}";
      "github.com".identityFile = "${config.sops.secrets.github-private-key.path}";
    };
  };
}
