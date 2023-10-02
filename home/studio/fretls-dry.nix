{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "fretls-dry";

  src = fetchGit {
    url = "git@github.com:evenbrenden/fretls-dry.git";
    rev = "cf80dd097a587668494877b20f409729f629c4f6";
  };

  installPhase = ''
    install -Dm444 -t $out/share/sfz/fretls-dry *
  '';
}
