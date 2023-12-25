{ pkgs }:

let
  the-witchs-broom = pkgs.fetchurl {
    url = "https://jimstar11.com/NGC6960_Bicolor4.jpg";
    sha256 = "sha256-eZbTyC1JzE7kQ0ngNRYjrznOLeCCBlcXsFq0omJ8C3s=";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -cover ${the-witchs-broom}
  '';
}
