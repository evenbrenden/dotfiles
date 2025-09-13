{ config, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "codeberg.org".identityFile = "${config.sops.secrets.codeberg-org-private-key.path}";
      "github.com".identityFile = "${config.sops.secrets.github-com-private-key.path}";
      "*".sendEnv = [ "COLORTERM" ];
    };
  };

  services.ssh-agent.enable = true;
}
