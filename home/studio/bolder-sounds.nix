{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "bolder-sounds";

  src = pkgs.requireFile {
    name = "bolder-sounds.tar.gz";
    url = "bolder-sounds.tar.gz";
    sha256 = "1sgj9wdlqw7gf6wfxp4q2qvv99pvb9rdcwfjzkf3ri5jmqyadqah";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/bolder-sounds
    cp -r * $out/share/sfz/bolder-sounds
  '';
}
