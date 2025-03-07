{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "lexicon-lxp-1-impulse-responses";

  src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "evenbrenden";
    repo = "lexicon-lxp-1-impulse-responses";
    rev = "61d7c66813b9d4305297b0a9b7c62beacd4a9dac";
    hash = "sha256-IvSuKYpcdYK8/9AHM5O88ATY3vkiUEczIWZgT0QCIhU=";
  };

  installPhase = ''
    mkdir -p $out/share/ir/lexicon-lxp-1-impulse-responses
    cp -a * $out/share/ir/lexicon-lxp-1-impulse-responses
  '';
}
