{ pkgs, stdenv }:

stdenv.mkDerivation {
  name = "rclone-sync";
  buildInputs = [ pkgs.python37 ];
  unpackPhase = ":";
  installPhase = ''
    install -m755 -D ${./rclone-sync.py} $out/bin/rclone-sync
    substituteInPlace $out/bin/rclone-sync --replace 'rclone-sync' 'temp'
    substituteInPlace $out/bin/rclone-sync --replace 'rclone' '${pkgs.rclone}/bin/rclone'
    substituteInPlace $out/bin/rclone-sync --replace 'temp' 'rclone-sync'
  '';
}

