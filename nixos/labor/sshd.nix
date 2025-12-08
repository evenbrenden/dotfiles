{ pkgs, ... }:

{
  services = {
    openssh = {
      enable = true;
      extraConfig = builtins.readFile "${pkgs.huddly}/ssh/sshd_config";
    };
    openvpn.servers.work.autoStart = true;
  };

  # Waiting for VPN connection
  systemd.services.sshd.serviceConfig = {
    RestartSec = 60;
    StartLimitInterval = 600;
    StartLimitBurst = 10;
  };
}
