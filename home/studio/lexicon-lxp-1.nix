{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "lexicon-lxp-1";

  src = pkgs.requireFile {
    name = "lexicon-lxp-1.tar.gz";
    url = "lexicon-lxp-1.tar.gz";
    sha256 = "1wrkp50i0f3bdzrrxcqkjz2li5r1hjg36q625yxqif8wfjiix99s";
  };

  installPhase = ''
    mkdir -p $out/share/studio/impulse-responses/lexicon-lxp-1
    cp -r * $out/share/studio/impulse-responses/lexicon-lxp-1
  '';
}
