{ pkgs, username }:

# https://discourse.nixos.org/t/set-up-vagrant-with-libvirt-qemu-kvm-on-nixos/14653
{
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  environment.systemPackages = [ pkgs.vagrant ];
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
  users.users.${username}.extraGroups = [ "docker" "libvirtd" ];
}
