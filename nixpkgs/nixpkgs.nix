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
        alsa-utils = prev.callPackage (import ./alsa-utils.nix) { }; # https://github.com/NixOS/nixpkgs/issues/432786
        clangd_wrapper = import ./clangd_wrapper.nix { pkgs = prev; };
        fourmolu-all = import ./fourmolu-all.nix { pkgs = prev; };
        git-replace = import ./git-replace.nix { pkgs = prev; };
        huddly = import ./huddly.nix;
        nixfmt-all = import ./nixfmt-all.nix { pkgs = final; };
        nixfmt-classic = import ./nixfmt-classic.nix { pkgs = prev; };
        refresh-display = import ./refresh-display.nix { pkgs = prev; };
        refresh-wallpaper = import ./refresh-wallpaper.nix { pkgs = prev; };
        set-dpi = import ./set-dpi.nix { pkgs = prev; };
        sof-firmware = with prev; import ./sof-firmware.nix { inherit fetchurl lib stdenvNoCC; };
        toggle-keyboard-layout = import ./toggle-keyboard-layout.nix { pkgs = prev; };
        unstable = import nixpkgs-unstable { inherit config system; };
        xorg = prev.xorg // {
          xkeyboardconfig-norwerty = import ./xkeyboardconfig-norwerty/xkeyboardconfig-norwerty.nix { pkgs = prev; };
        };
      })
      i3quo.overlay
    ];
  };
}
