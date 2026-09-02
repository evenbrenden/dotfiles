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
    nono
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

  xdg.configFile."nono/profiles/falcon-app.json".source =
    "${pkgs.huddly}/nono/profiles/falcon-app.json";
}
