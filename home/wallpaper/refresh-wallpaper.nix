{ pkgs }:

let
  water-lillies = pkgs.fetchurl {
    url = "https://upload.wikimedia.org/wikipedia/commons/6/64/Claude_Monet_-_Water_Lilies,_1917-1919.JPG";
    sha256 = "sha256-Q80IpSUFGWFagCIYpzeYz48MEN5yLdLvvPFljXzqL9o=";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -cover ${water-lillies}
  '';
}
