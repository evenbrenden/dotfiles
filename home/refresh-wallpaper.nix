{ pkgs }:

# Tetradic colors #104E8B #8B108B #8B4D10 #118B10
pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -add '#8B108B' -add '#8B4D10' -gradient 45
  '';
}
