{ username }:

{
  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      # https://discourse.nixos.org/t/virtualbox-keeps-getting-rebuilt/6612
      enableExtensionPack = false;
    };
  };
  users.users.${username}.extraGroups = [ "docker" "vboxusers" ];
}
