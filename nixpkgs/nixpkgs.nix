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
        fourmolu-all = import ./fourmolu-all.nix { pkgs = prev; };
        git-replace = import ./git-replace.nix { pkgs = prev; };
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
        x-www-browser = import ./x-www-browser.nix { pkgs = prev; };
      })
      i3quo.overlay
    ];
  };
}
