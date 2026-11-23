{ config, pkgs, ... }:

{
  dbus.packages = [ pkgs.gcr ]; # For keyring password prompter

  home.packages = with pkgs; [
    agent
    unstable.claude-code
    gh
    herdr
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
    spec
    usbutils
  ];

  programs.ssh.settings = {
    "labor" = {
      AddKeysToAgent = "yes";
      IdentityFile = "${config.home.homeDirectory}/.ssh/evenbrenden-work";
    };
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };
}
