{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "dsmolken-double-bass";

  src = pkgs.fetchFromGitHub {
    owner = "sfzinstruments";
    repo = "dsmolken.double-bass";
    rev = "v1.001";
    sha256 = "sha256-KC/uqQhr47xyalGbTuFaw63vhNZssssWeuwl9leD8nc=";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/dsmolken-double-bass
    cp -a * $out/share/sfz/dsmolken-double-bass
  '';
}
