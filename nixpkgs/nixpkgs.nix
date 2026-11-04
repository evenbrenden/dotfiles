{
  i3quo,
  nixpkgs-unstable,
  system,
}:

let
  config = {
    allowUnfree = true;
    pulseaudio = true; # https://nixos.wiki/wiki/PulseAudio
  };
in
{
  nixpkgs = {
    inherit config;
    overlays = [
      (final: prev: {
        clear-downloads = import ./clear-downloads.nix { pkgs = prev; };
        git-replace = import ./git-replace.nix { pkgs = prev; };
        huddly = import ./huddly.nix;
        huddly-cli = import ./huddly-cli.nix { pkgs = prev; };
        refresh-display = import ./refresh-display.nix { pkgs = prev; };
        set-dpi = import ./set-dpi.nix { pkgs = prev; };
        sof-firmware = with prev; import ./sof-firmware.nix { inherit fetchurl lib stdenvNoCC; };
        spec = import ./spec.nix { pkgs = prev; };
        toggle-keyboard-layout = import ./toggle-keyboard-layout.nix { pkgs = prev; };
        unstable = import nixpkgs-unstable { inherit config system; };
        xkeyboardconfig-norwerty = import ./xkeyboardconfig-norwerty/xkeyboardconfig-norwerty.nix {
          pkgs = prev;
        };
      })
      i3quo.overlay
    ];
  };
}
