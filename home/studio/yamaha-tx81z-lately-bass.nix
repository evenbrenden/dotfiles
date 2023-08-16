{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "yamaha-tx81z-lately-bass";

  src = pkgs.fetchzip {
    url = "http://www.tiltshiftgallery.se/audio/yamaha_tx81z_lately_bass.zip";
    sha256 = "sha256-KViSOLl3+M1VYWE+i2Y38jJK8SuNS56eHhKb8wkwGTA=";
  };

  installPhase = ''
    mkdir -p $out/share/studio/instruments/yamaha-tx81z-lately-bass
    cp -r * $out/share/studio/instruments/yamaha-tx81z-lately-bass
  '';
}
