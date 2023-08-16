{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "fretls";

  src = fetchGit {
    url = "git@github.com:evenbrenden/fretls.git";
    rev = "0f00a4eaa2d6d49ca9ac96e3e80457482f158888";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/fretls
    cp -r * $out/share/sfz/fretls
  '';
}
