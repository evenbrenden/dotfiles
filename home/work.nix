{ pkgs, ... }:

{
  home.packages = with pkgs; [ huddly-cli libqalculate meld netron networkmanagerapplet roomeqwizard usbutils ];

  programs.ssh.includes = [ "${pkgs.huddly}/ssh/icefish" "${pkgs.huddly}/ssh/huddly" ];
}
