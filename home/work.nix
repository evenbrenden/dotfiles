{ pkgs, ... }:

{
  home.packages = with pkgs; [ conan google-cloud-sdk meld pre-commit roomeqwizard usbutils ];

  programs.ssh.extraConfig = builtins.readFile "${pkgs.huddly}/ssh/icelocal";
}
