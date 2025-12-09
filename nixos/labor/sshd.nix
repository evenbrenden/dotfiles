{ pkgs, ... }:

{
  services = {
    openssh = {
      enable = true;
      extraConfig = builtins.readFile "${pkgs.huddly}/ssh/sshd_config";
    };
    openvpn.servers.work.autoStart = pkgs.lib.mkForce true;
  };

  # Waiting for VPN connection
  systemd.services.sshd = {
    unitConfig = {
      StartLimitBurst = 10;
      StartLimitInterval = 600;
    };
    serviceConfig.RestartSec = 60;
  };
}
