{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "jsteeldrum";

  src = pkgs.fetchFromGitHub {
    owner = "sfzinstruments";
    repo = "jlearman.SteelDrum";
    rev = "e429428dd65dc645e4c9b1f134da4d2e40c400c6";
    sha256 = "sha256-zLLskiJF8D2tR5gN2Yok4c2jFLUm5SZwEODaTtxRXmo=";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/jsteeldrum
    cp -a * $out/share/sfz/jsteeldrum
  '';
}
