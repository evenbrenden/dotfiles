{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "virtuosity-drums";
  version = "0.924";

  src = pkgs.fetchFromGitHub {
    owner = "sfzinstruments";
    repo = "virtuosity_drums";
    rev = "v0.924";
    sha256 = "sha256-kedn/auowOdejv0CE97Xvc3t7tkaIqnYEk0KtNO+Md4=";
  };

  installPhase = ''
    mkdir -p $out/lib/sfz/virtuosity_drums
    cp -r * $out/lib/sfz/virtuosity_drums
  '';
}
