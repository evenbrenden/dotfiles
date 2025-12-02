{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "codeberg.org".identityFile = "${config.sops.secrets.codeberg-org-private-key.path}";
      "github.com".identityFile = "${config.sops.secrets.github-com-private-key.path}";
      "*" = {
        addKeysToAgent = "no";
        controlMaster = "no";
        controlPersist = "no";
        forwardAgent = false;
        hashKnownHosts = false;
        sendEnv = [ "COLORTERM" ];
      };
    };
  };

  services.ssh-agent.enable = true;
}
