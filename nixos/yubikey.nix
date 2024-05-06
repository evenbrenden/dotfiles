# https://nixos.wiki/wiki/Yubikey

{ pkgs, ... }: {

  environment.systemPackages = [ pkgs.yubioath-flutter ];

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };
}
