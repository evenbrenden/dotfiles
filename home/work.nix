{ pkgs, ... }:

{
  home.packages = with pkgs; [ conan google-cloud-sdk meld netron pre-commit roomeqwizard usbutils ];

  programs.ssh.includes = [ "${pkgs.huddly}/ssh/icefish" "${pkgs.huddly}/ssh/labor" ];
}
