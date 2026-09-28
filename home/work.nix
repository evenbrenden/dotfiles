{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
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
    usbutils
  ];

  programs.ssh.settings = {
    "labor" = {
      AddKeysToAgent = "yes";
      IdentityFile = "${config.home.homeDirectory}/.ssh/evenbrenden-work";
    };
  };
}
