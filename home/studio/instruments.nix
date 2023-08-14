{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "instruments";

  src = pkgs.requireFile {
    name = "instruments.tar.gz";
    url = "instruments.tar.gz";
    sha256 = "1hdfgr6m2bdjxmwkvk0fy92b7pjs1z5px81100qiinvg0m54wg2c";
  };

  installPhase = ''
    mkdir -p $out/share/studio/instruments
    cp -r * $out/share/studio/instruments
  '';
}
