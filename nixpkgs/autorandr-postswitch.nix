{ pkgs }:

pkgs.writeShellApplication {
  name = "autorandr-postswitch";
  runtimeInputs = with pkgs; [ refresh-wallpaper systemd ];
  text = ''
    refresh-wallpaper
    systemctl --user restart dunst.service
    systemctl --user restart parcellite.service
  '';
}
