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
    ripgrep
    roomeqwizard
    usbutils
  ];

  programs.ssh.includes = [ "${pkgs.huddly}/ssh/huddly" "${pkgs.huddly}/ssh/fish" ];
}
