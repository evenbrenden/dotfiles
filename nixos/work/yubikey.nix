# https://nixos.wiki/wiki/Yubikey

{ pkgs, ... }: {

  # https://github.com/NixOS/nixpkgs/issues/353664
  # environment.systemPackages = [ pkgs.yubioath-flutter ];

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };
}
