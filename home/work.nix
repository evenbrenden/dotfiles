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

  programs.ssh = {
    includes = [
      "${pkgs.huddly}/ssh/ssh_ci_config"
      "${pkgs.huddly}/ssh/ssh_config"
    ];
    settings = {
      "hubba" = {
        AddKeysToAgent = "yes";
        IdentityFile = "${config.home.homeDirectory}/.ssh/even.brenden";
        Hostname = "10.100.99.169";
      };
    };
  };
}
