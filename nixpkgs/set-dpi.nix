{ pkgs }:

pkgs.writeShellApplication {
  name = "set-dpi";
  runtimeInputs = with pkgs; [ xrandr xrdb ];
  text = ''
    xrandr --dpi "$1" && echo "Xft.dpi: $1" | xrdb -merge
  '';
}
