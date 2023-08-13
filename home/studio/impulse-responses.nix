{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "impulse-responses";

  src = pkgs.requireFile {
    name = "impulse-responses.tar.gz";
    url = "impulse-responses.tar.gz";
    sha256 = "08n01yp8qr5yd3xr5ypn1kmwl9wi3p2lx4m7q2mczlgw79kqx9fd";
  };

  installPhase = ''
    mkdir -p $out/share/studio/impulse-responses
    cp -r * $out/share/studio/impulse-responses
  '';
}
