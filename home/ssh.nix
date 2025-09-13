{ config, ... }:

{
  # https://github.com/nix-community/home-manager/pull/7655
  programs.ssh = {
    enable = true;
    addKeysToAgent = "no";
    controlMaster = "no";
    controlPersist = "no";
    forwardAgent = false;
    hashKnownHosts = false;
    matchBlocks = {
      "codeberg.org".identityFile = "${config.sops.secrets.codeberg-org-private-key.path}";
      "github.com".identityFile = "${config.sops.secrets.github-com-private-key.path}";
      "*".sendEnv = [ "COLORTERM" ];
    };
  };

  services.ssh-agent.enable = true;
}
