{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "digital-sound-factory";

  src = pkgs.requireFile {
    name = "digital-sound-factory.tar.gz";
    url = "digital-sound-factory.tar.gz";
    sha256 = "0r7vsifk8apy4ywnr11sc1rr3sf3iqx8gv18f990hdbn81spmvbf";
  };

  installPhase = ''
    mkdir -p $out/share/sf2/digital-sound-factory
    cp -r * $out/share/sf2/digital-sound-factory
  '';
}
