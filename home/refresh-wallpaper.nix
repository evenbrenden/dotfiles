{ pkgs }:

# https://www.discogs.com/master/470489-Laurie-Spiegel-The-Expanding-Universe
# https://github.com/himdel/hsetroot/issues/42
pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -add '#DB3796' -add '#FAD905' -gradient 0
  '';
}
