{ pkgs, username }:

{
  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = false;
      # https://discourse.nixos.org/t/virtualbox-keeps-getting-rebuilt/6612
      enableExtensionPack = true;
    };
  };

  users.users.${username}.extraGroups = [ "docker" "vboxusers" ];
}
