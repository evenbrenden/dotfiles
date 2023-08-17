{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "instant-midi-drum-patterns";

  src = pkgs.fetchzip {
    url = "https://web.archive.org/web/20190305092857/http://www.fivepinpress.com/InstantDrumPatterns.zip";
    sha256 = "sha256-mklEKxQ5DlRzuvw4QvR20SRp/zGGOUadClk1keBqdy8=";
  };

  installPhase = let url = "https://web.archive.org/web/20190305092857/http://www.fivepinpress.com/drum_patterns.html";
  in ''
    mkdir -p $out/share/midi/instant-midi-drum-patterns
    cp -r * $out/share/midi/instant-midi-drum-patterns
    echo ${url} > $out/share/midi/instant-midi-drum-patterns/instant-midi-drum-patterns.url
  '';
}
