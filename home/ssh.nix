{ config, ... }:

{
  # https://github.com/nix-community/home-manager/pull/7737
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*".sendEnv = [ "COLORTERM" ];
      "codeberg.org".identityFile = "${config.sops.secrets.codeberg-org-private-key.path}";
      "github.com".identityFile = "${config.sops.secrets.github-com-private-key.path}";
    };
  };

  services.ssh-agent.enable = true;
}
