{ pkgs }:

let
  narcissus = pkgs.fetchurl {
    url = "https://elemmental.com/wp-content/uploads/2018/12/Andy-Dixon-Narcissus-Painting-139-X-80-2018.jpg";
    sha256 = "sha256-NbDYibYjSq3u2z7206H2Rl4W/DOcKLuLhz00PEMgwbo=";
  };
  the-witchs-broom = pkgs.fetchurl {
    url = "https://jimstar11.com/NGC6960_Bicolor4.jpg";
    sha256 = "sha256-eZbTyC1JzE7kQ0ngNRYjrznOLeCCBlcXsFq0omJ8C3s=";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -cover ${the-witchs-broom} -center ${narcissus}
  '';
}
