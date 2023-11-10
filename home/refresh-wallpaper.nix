{ pkgs }:

pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -cover ${./henri-matisse-the-swimmer-in-the-tank.jpeg}
  '';
}
