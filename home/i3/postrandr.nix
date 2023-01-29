{ pkgs }:

pkgs.writeShellApplication {
  name = "postrandr";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -tile ${./stars.jpeg}
  '';
}
