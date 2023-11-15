{ pkgs }:

pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -alpha 96 -cover ${./henri-rosseau-le-reve.jpeg}
  '';
}
