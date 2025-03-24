{ pkgs }:

pkgs.stdenv.mkDerivation {

  name = "norwerty";

  src = pkgs.fetchFromGitHub {
    owner = "tobiasvl";
    repo = "norwerty";
    rev = "4de0b54129867d4f123fc038a4cf847503717898";
    sha256 = "sha256-7qdsRVIKDJlp8QMzJhjqQNnNBv8IeOw/ucb0lP+QWNc=";
  };

  patches = [ ./0001-Linux-Include-basic-Norwegian.patch ];

  installPhase = ''
    mkdir -p $out/share/X11/xkb/symbols
    install -Dm444 linux/no.txt $out/share/X11/xkb/symbols/norwerty
  '';
}
