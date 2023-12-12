{ pkgs }:

pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -tile ${./stars.jpeg} -center ${./andy-dixon-narcissus.jpeg}
  '';
}
