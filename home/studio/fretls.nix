{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "fretls";

  src = fetchGit {
    url = "git@github.com:evenbrenden/fretls.git";
    rev = "0f00a4eaa2d6d49ca9ac96e3e80457482f158888";
  };

  installPhase = ''
    mkdir -p $out/share/studio/instruments/fretls
    cp -r * $out/share/studio/instruments/fretls
  '';
}
