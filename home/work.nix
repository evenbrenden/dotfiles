{ pkgs, ... }:

{
  home.packages = with pkgs; [
    busybox
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
