{ pkgs, username }:

let
  vagrant = {
    boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
    environment.systemPackages = [ pkgs.vagrant ];
    virtualisation.libvirtd.enable = true;
    users.users.${username}.extraGroups = [ "libvirtd" ];
  };
  docker = {
    virtualisation.docker.enable = true;
    users.users.${username}.extraGroups = [ "docker" ];
  };
in docker // vagrant
