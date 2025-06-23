(final: prev: {
  ac-upright = import ./ac-upright.nix { pkgs = prev; };
  dsmolken-double-bass = import ./dsmolken-double-bass.nix { pkgs = prev; };
  fretls-dry = import ./fretls-dry.nix { pkgs = prev; };
  instant-midi-drum-patterns = import ./instant-midi-drum-patterns.nix { pkgs = prev; };
  jsteeldrum = import ./jsteeldrum.nix { pkgs = prev; };
  lexicon-lxp-1-impulse-responses = import ./lexicon-lxp-1-impulse-responses.nix { pkgs = prev; };
  virtuosity-drums = import ./virtuosity-drums.nix { pkgs = prev; };
  wet-fretls = import ./wet-fretls.nix { pkgs = prev; };
  yamaha-tx81z-lately-bass = import ./yamaha-tx81z-lately-bass.nix { pkgs = prev; };
})
