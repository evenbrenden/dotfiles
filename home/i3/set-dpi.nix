{ pkgs }:

pkgs.writeShellApplication {
  name = "set-dpi";
  text = ''
    xrandr --dpi "$1" && echo "Xft.dpi: $1" | xrdb -merge
  '';
}
