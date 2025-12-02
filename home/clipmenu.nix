{ ... }:

{
  services.clipmenu.enable = true;
  systemd.user.services.clipmenu.Service.Environment =
    [ "CM_MAX_CLIPS=10" ]; # https://github.com/nix-community/home-manager/pull/8255
}
