# https://nixos.wiki/wiki/Yubikey

{ pkgs, ... }: {

  environment.systemPackages = [ pkgs.yubioath-desktop ];

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };
}
