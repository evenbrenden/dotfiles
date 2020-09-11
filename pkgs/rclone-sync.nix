{ pkgs, stdenv }:

stdenv.mkDerivation {
  name = "rclone-sync";
  buildInputs = [ pkgs.python37 ];
  unpackPhase = ":";
  installPhase = ''
    install -m755 -D ${./rclone-sync.py} $out/bin/rclone-sync
    export rclone=${pkgs.rclone}/bin/rclone
    substituteAllInPlace $out/bin/rclone-sync
  '';
}

