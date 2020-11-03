{ pkgs, stdenv }:

stdenv.mkDerivation {
  name = "rclone-sync";
  nativeBuildInputs = [ pkgs.makeWrapper ];
  unpackPhase = ":";
  installPhase = ''
    makeWrapper ${./rclone-sync.py} $out/bin/rclone-sync \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.python37 pkgs.rclone ]}
  '';
}
