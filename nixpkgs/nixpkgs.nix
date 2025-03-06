{ i3quo, nixpkgs-unstable, system }:

let
  config = {
    allowUnfree = true;
    pulseaudio = true; # https://nixos.wiki/wiki/PulseAudio
  };
in {
  nixpkgs = {
    inherit config;
    overlays = [
      (final: prev: {
        alacritty-xcwd = import ./alacritty-xcwd.nix { pkgs = prev; };
        fourmolu-all = import ./fourmolu-all.nix { pkgs = prev; };
        git-replace = import ./git-replace.nix { pkgs = prev; };
        nixfmt-all = import ./nixfmt-all.nix { pkgs = final; };
        nixfmt-classic = import ./nixfmt-classic.nix { pkgs = prev; };
        refresh-wallpaper = import ./refresh-wallpaper.nix { pkgs = prev; };
        set-dpi = import ./set-dpi.nix { pkgs = prev; };
        sof-firmware = with prev; import ./sof-firmware.nix { inherit fetchurl lib stdenvNoCC; };
        studio = {
          ac-upright = import ./studio/ac-upright.nix { pkgs = prev; };
          bolder-sounds = import ./studio/bolder-sounds.nix { pkgs = prev; };
          digital-sound-factory = import ./studio/digital-sound-factory.nix { pkgs = prev; };
          dsmolken-double-bass = import ./studio/dsmolken-double-bass.nix { pkgs = prev; };
          fretls-dry = import ./studio/fretls-dry.nix { pkgs = prev; };
          instant-midi-drum-patterns = import ./studio/instant-midi-drum-patterns.nix { pkgs = prev; };
          ivy-audio = import ./studio/ivy-audio.nix { pkgs = prev; };
          jsteeldrum = import ./studio/jsteeldrum.nix { pkgs = prev; };
          lexicon-lxp-1-impulse-responses = import ./studio/lexicon-lxp-1-impulse-responses.nix { pkgs = prev; };
          samples-from-mars = import ./studio/samples-from-mars.nix { pkgs = prev; };
          virtuosity-drums = import ./studio/virtuosity-drums.nix { pkgs = prev; };
          wet-fretls = import ./studio/wet-fretls.nix { pkgs = prev; };
          yamaha-tx81z-lately-bass = import ./studio/yamaha-tx81z-lately-bass.nix { pkgs = prev; };
        };
        toggle-keyboard-layout = import ./toggle-keyboard-layout.nix { pkgs = prev; };
        # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
        unstable = import nixpkgs-unstable { inherit system config; };
        x-www-browser = import ./x-www-browser.nix { pkgs = prev; };
      })
      i3quo.overlay
    ];
  };
}
