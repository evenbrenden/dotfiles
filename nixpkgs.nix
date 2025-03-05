{ system, nixpkgs-unstable, i3quo }:

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
        unstable = import nixpkgs-unstable {
          inherit system config;
        }; # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
        sof-firmware = with prev; import ./nixos/naxos/sof-firmware.nix { inherit fetchurl lib stdenvNoCC; };
      })
      i3quo.overlay
    ];
  };
}
