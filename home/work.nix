{ config, pkgs, ... }:

{
  dbus.packages = [ pkgs.gcr ]; # For keyring password prompter

  home.packages = with pkgs; [
    unstable.claude-code
    gh
    huddly-cli
    libqalculate
    meld
    netron
    networkmanagerapplet
    unstable.nono
    poppler-utils
    ripgrep
    roomeqwizard
    libsecret
    usbutils
  ];

  programs = {
    herdr.enable = true;
    ssh.settings = {
      "labor" = {
        AddKeysToAgent = "yes";
        IdentityFile = "${config.home.homeDirectory}/.ssh/evenbrenden-work";
      };
    };
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };
}
