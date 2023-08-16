{ pkgs, url, sha256 }:

pkgs.stdenv.mkDerivation {
  name = url;

  src = pkgs.requireFile {
    url = url;
    sha256 = sha256;
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
