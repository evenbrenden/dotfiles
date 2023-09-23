{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "bolder-sounds";

  src = pkgs.requireFile {
    name = "bolder-sounds.tar.gz";
    url = "bolder-sounds.tar.gz";
    sha256 = "15hdsl2wq8a4rcx28ylsvw4sz7fd959x4q4n9fn7crxcfr4w8pw7";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/bolder-sounds
    cp -a * $out/share/sfz/bolder-sounds
  '';
}
