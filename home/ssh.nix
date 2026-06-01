{ config, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "codeberg.org" = {
        AddKeysToAgent = "yes";
        IdentityFile = "${config.sops.secrets.evenbrenden_at_noreply_dot_codeberg_dot_org.path}";
      };
      "github.com" = {
        AddKeysToAgent = "yes";
        IdentityFile = "${config.sops.secrets.evenbrenden_at_users_dot_noreply_dot_github_dot_com.path}";
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
