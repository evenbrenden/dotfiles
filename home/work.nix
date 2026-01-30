{ pkgs, ... }:

{
  home.packages = with pkgs; [
    codex
    huddly-cli
    libqalculate
    meld
    netron
    networkmanagerapplet
    poppler-utils
    roomeqwizard
    usbutils
  ];

  programs.ssh.includes = [ "${pkgs.huddly}/ssh/huddly" ];
}
