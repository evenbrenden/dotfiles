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
        nixfmt-classic = import home/nixfmt-classic.nix { pkgs = prev; };
        sof-firmware = with prev; import ./nixos/naxos/sof-firmware.nix { inherit fetchurl lib stdenvNoCC; };
        # https://discourse.nixos.org/t/using-nixpkgs-legacypackages-system-vs-import/17462/3
        unstable = import nixpkgs-unstable { inherit system config; };
      })
      i3quo.overlay
    ];
  };
}
