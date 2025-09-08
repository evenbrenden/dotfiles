{ username, ... }:

{
  services.openvpn.servers.work = {
    autoStart = false;
    config = "config /home/${username}/openvpn/work.ovpn";
    updateResolvConf = true;
  };
}
