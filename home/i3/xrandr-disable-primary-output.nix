{ pkgs }:

pkgs.writeShellApplication {
  name = "xrandr-disable-primary-output";
  text = ''
    primary=$(xrandr | grep primary | cut -f 1 -d ' ')
    xrandr --output "$primary" --off
  '';
}
