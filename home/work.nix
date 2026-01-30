{ pkgs, ... }:

{
  home.packages = with pkgs; [
    codex
    huddly-cli
    inetutils
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
