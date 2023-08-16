{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "samples-from-mars";

  src = pkgs.requireFile {
    name = "samples-from-mars.tar.gz";
    url = "samples-from-mars.tar.gz";
    sha256 = "1zndas1akl75yx2x201ngs2dcj148mhja7b5j1vf1sqrx3jidfvr";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/samples-from-mars
    cp -r * $out/share/sfz/samples-from-mars
  '';
}
