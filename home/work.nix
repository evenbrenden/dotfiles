{ pkgs, ... }:

{
  home.packages = with pkgs; [ roomeqwizard usbutils ];

  programs.ssh.extraConfig = builtins.readFile "${pkgs.huddly}/ssh/icelocal";
}
