{ pkgs }:

# https://github.com/himdel/hsetroot/issues/42
let
  the-expanding-universe = pkgs.stdenv.mkDerivation {
    name = "the-expanding-universe";
    src = null;
    unpackPhase = "true";
    nativeBuildInputs = [ pkgs.imagemagick ];
    buildPhase = ''
      magick -size 5120x2160 -define gradient:angle=30 gradient:#FDE507-#FA2AB4 the-expanding-universe-a.png
      magick -size 5120x2160 -define gradient:angle=30 gradient:#D00E91-#069AFC the-expanding-universe-b.png
    '';
    installPhase = ''
      mkdir -p $out/share/wallpapers
      cp the-expanding-universe-a.png $out/share/wallpapers/the-expanding-universe-a.png
      cp the-expanding-universe-b.png $out/share/wallpapers/the-expanding-universe-b.png
    '';
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ coreutils hsetroot ];
  text = ''
    current_hour=$(date +%H)
    if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 18 ]; then
      hsetroot -fill ${the-expanding-universe}/share/wallpapers/the-expanding-universe-a.png
    else
      hsetroot -fill ${the-expanding-universe}/share/wallpapers/the-expanding-universe-b.png
    fi
  '';
}
