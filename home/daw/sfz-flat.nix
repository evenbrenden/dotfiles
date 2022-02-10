{ cmake, pkgs, stdenv }:

stdenv.mkDerivation rec {
  name = "sfz-flat";

  src = pkgs.fetchFromGitHub {
    owner = "sfztools";
    repo = "sfz-flat";
    rev = "e2648b796099fb39695c1ec440c1cb8875770940";
    sha256 = "1dz9jc1napf6m3fhivy3jkl0slip4a8bk58v035frzlxi3mq53c0";
    fetchSubmodules = true;
  };

  buildInputs = [ cmake ];

  installPhase = ''
    mkdir -p $out/bin
    cp sfz-flat $out/bin
  '';
}
