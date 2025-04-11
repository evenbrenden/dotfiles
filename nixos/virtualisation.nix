{ pkgs, username }:

{
  environment.systemPackages = [ pkgs.distrobox ];
  users.users.${username}.extraGroups = [ "docker" ];
  virtualisation.docker.enable = true;
}
