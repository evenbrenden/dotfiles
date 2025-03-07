{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "ac-upright";

  src = fetchGit {
    url = "git@github.com:evenbrenden/ac-upright.git";
    rev = "907ee4f1dc66ee1375a7bcd7fd47f58ab2105f62";
  };

  installPhase = ''
    install -Dm444 -t $out/share/sfz/ac-upright *
  '';
}
