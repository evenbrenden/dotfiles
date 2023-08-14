{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "greg-sullivan-e-pianos";

  src = pkgs.fetchFromGitHub {
    owner = "sfzinstruments";
    repo = "GregSullivan.E-Pianos";
    rev = "8c3e581acda3594b553948ff0222d4f84a698376";
    sha256 = "sha256-tpPNz1ev6AcoTfPMGbfTTTu2wbp6OG1m0f6pCJi9KAM=";
  };

  installPhase = ''
    mkdir -p $out/share/studio/sfz/GregSullivan.E-Pianos
    cp -r * $out/share/studio/sfz/GregSullivan.E-Pianos
  '';
}
