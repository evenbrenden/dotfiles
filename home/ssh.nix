{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "codeberg.org" = {
        addKeysToAgent = "yes";
        identityFile = "${config.sops.secrets.evenbrenden_at_noreply_dot_codeberg_dot_org.path}";
      };
      "github.com" = {
        addKeysToAgent = "yes";
        identityFile = "${config.sops.secrets.evenbrenden_at_users_dot_noreply_dot_github_dot_com.path}";
      };
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
