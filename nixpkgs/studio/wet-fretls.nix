{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "wet-fretls";

  src = fetchGit {
    url = "git@github.com:evenbrenden/wet-fretls.git";
    rev = "bd5cb6659e4f7a917c34d7695bf9156090a6ead1";
  };

  installPhase = ''
    install -Dm444 -t $out/share/sfz/wet-fretls *
  '';
}
