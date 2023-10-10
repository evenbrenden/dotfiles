{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "ac-upright";

  src = fetchGit {
    url = "git@github.com:evenbrenden/ac-upright.git";
    rev = "c9f055a364fb147b65e2c22fe3656c9af5eaa66d";
  };

  installPhase = ''
    install -Dm444 -t $out/share/sfz/ac-upright *
  '';
}
