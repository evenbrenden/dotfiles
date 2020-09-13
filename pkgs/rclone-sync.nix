{ pkgs, stdenv }:

stdenv.mkDerivation {
  name = "rclone-sync";
  nativeBuildInputs = [ pkgs.makeWrapper ];
  propagatedBuildInputs = [ pkgs.python37 ];
  unpackPhase = ":";
  installPhase = ''
    makeWrapper ${./rclone-sync.py} $out/bin/rclone-sync \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.rclone ]}
  '';
}
