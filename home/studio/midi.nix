{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "midi";

  src = pkgs.requireFile {
    name = "midi.tar.gz";
    url = "midi.tar.gz";
    sha256 = "13qnfms2c2vsgmbzfjvihzp7p0wzn81gmj5jwf7an1alln85p5fw";
  };

  installPhase = ''
    mkdir -p $out/share/studio/midi
    cp -r * $out/share/studio/midi
  '';
}
