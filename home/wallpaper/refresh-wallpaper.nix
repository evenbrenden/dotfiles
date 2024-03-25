{ pkgs }:

let
  world-map = pkgs.fetchurl {
    url = "https://www.surfertoday.com/images/stories/political-world-map.jpg";
    sha256 = "sha256-Weg/3pCT+rZEGTJL6D8xStxyIVzv20O+P22aMI+A89g=";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -cover ${world-map}
  '';
}
