{ pkgs }:

pkgs.stdenv.mkDerivation {

  name = "norwerty";

  src = pkgs.fetchFromGitHub {
    owner = "tobiasvl";
    repo = "norwerty";
    rev = "3d2cd0f1fda8744525bcfe3df1a1ce0578858195";
    sha256 = "sha256-AroOqU8aV3oid24WzTOsYhuHUULRNhA124lIuSIvZHo=";
  };

  patches = [ ./0001-Make-Linux-layout-standalone.patch ];

  installPhase = ''
    mkdir -p $out/share/X11/xkb/symbols
    install -Dm444 linux/no.txt $out/share/X11/xkb/symbols/norwerty
  '';
}
