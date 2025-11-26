{ pkgs, ... }:

{
  home.packages = with pkgs; [ libqalculate meld netron networkmanagerapplet roomeqwizard usbutils ];

  programs.ssh.includes = [ "${pkgs.huddly}/ssh/icefish" "${pkgs.huddly}/ssh/labor" ];
}
