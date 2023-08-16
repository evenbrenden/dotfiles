{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "digital-sound-factory";

  src = pkgs.requireFile {
    name = "digital-sound-factory.tar.gz";
    url = "digital-sound-factory.tar.gz";
    sha256 = "0r7vsifk8apy4ywnr11sc1rr3sf3iqx8gv18f990hdbn81spmvbf";
  };

  installPhase = ''
    mkdir -p $out/share/studio/instruments/digital-sound-factory
    cp -r * $out/share/studio/instruments/digital-sound-factory
  '';
}
