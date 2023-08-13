{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "instruments";

  src = pkgs.requireFile {
    name = "instruments.tar.gz";
    url = "instruments.tar.gz";
    sha256 = "14q9z068zjrc5himd34rf93z98xbfmnszwdcmg209ghkbq4cndlj";
  };

  installPhase = ''
    mkdir -p $out/share/studio/instruments
    cp -r * $out/share/studio/instruments
  '';
}
