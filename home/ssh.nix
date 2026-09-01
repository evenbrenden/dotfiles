{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "codeberg.org" = {
        AddKeysToAgent = "yes";
        IdentityFile = "${config.sops.secrets.evenbrenden.path}";
      };
      "github.com" = {
        AddKeysToAgent = "yes";
        IdentityFile = "${config.sops.secrets.evenbrenden.path}";
      };
      "*" = {
        AddKeysToAgent = "no";
        ControlMaster = "no";
        ControlPersist = "no";
        ForwardAgent = false;
        HashKnownHosts = false;
        SendEnv = [ "COLORTERM" ];
      };
    };
  };

  services.ssh-agent.enable = true;
}
