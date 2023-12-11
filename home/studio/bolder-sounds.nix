{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "bolder-sounds";

  src = pkgs.requireFile {
    name = "bolder-sounds.tar.gz";
    url = "bolder-sounds.tar.gz";
    sha256 = "0p93l3nls8x8a70b5g6fpsrki8f12xdblvrp6fhzjss6ps57harb";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/bolder-sounds
    cp -a * $out/share/sfz/bolder-sounds
  '';
}
