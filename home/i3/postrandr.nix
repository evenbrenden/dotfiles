{ pkgs }:

pkgs.writeShellApplication {
  name = "postrandr";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -cover ~/wall.jpeg
  '';
}
