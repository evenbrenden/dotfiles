{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
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

  programs.ssh.includes = [
    "${pkgs.huddly}/ssh/ssh_ci_config"
    "${pkgs.huddly}/ssh/ssh_config"
  ];
}
