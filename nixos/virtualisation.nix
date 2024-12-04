{ pkgs, username }:

{
  virtualisation = {
    # Docker
    docker.enable = true;

    # VirtualBox
    virtualbox.host = {
      enable = true;
      # https://discourse.nixos.org/t/virtualbox-keeps-getting-rebuilt/6612
      enableExtensionPack = true;
    };
  };

  # Groups
  users.users.${username}.extraGroups = [ "docker" "vboxusers" ];
}
