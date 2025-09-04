{ pkgs, ... }:

{
  home.packages = with pkgs; [ google-cloud-sdk roomeqwizard usbutils ];

  programs.ssh.extraConfig = builtins.readFile "${pkgs.huddly}/ssh/icelocal";
}
