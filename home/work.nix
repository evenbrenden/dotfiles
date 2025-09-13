{ pkgs, ... }:

{
  home.packages = with pkgs; [ conan google-cloud-sdk meld pre-commit roomeqwizard usbutils ];

  programs.ssh.includes = [ "${pkgs.huddly}/ssh/icelocal" "${pkgs.huddly}/ssh/labor" ];
}
