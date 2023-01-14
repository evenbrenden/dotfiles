{ pkgs }:

pkgs.writeShellApplication {
  name = "auto-x";
  runtimeInputs = with pkgs; [ autorandr hsetroot ];
  text = ''
    autorandr --change
    hsetroot -cover ~/wall.jpeg
  '';
}
