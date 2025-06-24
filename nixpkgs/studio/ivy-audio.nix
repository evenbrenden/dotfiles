{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "ivy-audio";

  src = pkgs.requireFile {
    name = "ivy-audio.tar.gz";
    url = "ivy-audio.tar.gz";
    sha256 = "1lyi254srlgmyyzgd0lyd5ybcgw13pankw7s0nk83afjgp3hmfmx";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/ivy-audio
    cp -a * $out/share/sfz/ivy-audio
  '';
}
