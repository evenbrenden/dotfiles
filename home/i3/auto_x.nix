{ pkgs }:

pkgs.writeShellApplication {
  name = "auto_x";
  runtimeInputs = with pkgs; [ autorandr hsetroot ];
  text = ''
    autorandr --change
    hsetroot -cover ~/wall.jpeg
  '';
}
