{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    gh
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
    "${pkgs.huddly}/ssh/hubba"
    "${pkgs.huddly}/ssh/ssh_ci_config"
    "${pkgs.huddly}/ssh/ssh_config"
  ];
}
