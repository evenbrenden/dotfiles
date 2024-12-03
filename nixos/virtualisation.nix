{ pkgs, username }:

{
  # Docker
  virtualisation.docker.enable = true;

  # Vagrant
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  # https://github.com/NixOS/nixpkgs/issues/348938
  # environment.systemPackages = [ pkgs.vagrant ];
  virtualisation.libvirtd.enable = true;

  # Groups
  users.users.${username}.extraGroups = [ "docker" "libvirtd" ];
}
