# https://nixos.wiki/wiki/Yubikey

{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.yubioath-flutter ];

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };
}
