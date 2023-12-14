{ pkgs }:

let
  math-is-universal = pkgs.stdenv.mkDerivation {
    name = "math-is-universal";
    src = pkgs.fetchurl {
      url = "https://i.imgur.com/FYxA2.jpeg";
      sha256 = "sha256-+dWII8TNDqWXkgAkSCqSFM/Sppu4JpEyFZrTDYxkdDo=";
    };
    unpackPhase = ''
      cp -a $src input.jpeg
    '';
    buildInputs = [ pkgs.imagemagick ];
    buildPhase = ''
      convert -bordercolor '#37201C' -border 84 -resize 50% input.jpeg output.jpeg
    '';
    installPhase = ''
      mkdir -p $out
      cp -a output.jpeg $out/math-is-universal.jpeg
    '';
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -solid '#265F64' -center ${math-is-universal}/math-is-universal.jpeg
  '';
}
