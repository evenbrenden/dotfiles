{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "fretls";

  src = fetchGit {
    url = "git@github.com:evenbrenden/fretls.git";
    rev = "2edb90532195140ca0d0ac0e55bf48a89e3937ee";
  };

  installPhase = ''
    mkdir -p $out/share/sfz/fretls
    cp -a * $out/share/sfz/fretls
  '';
}
