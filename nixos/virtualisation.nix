{ pkgs, username }:

{
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  environment.systemPackages = [ pkgs.vagrant ];
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
  users.users.${username}.extraGroups = [ "docker" "libvirtd" ];
}
