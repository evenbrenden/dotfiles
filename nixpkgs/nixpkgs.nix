{
  herdr,
  i3quo,
  nixpkgs-unstable,
  system,
}:

let
  config.allowUnfree = true;
in
{
  nixpkgs = {
    inherit config;
    overlays = [
      (final: prev: {
        agent = import ./agent.nix { pkgs = final; };
        git-replace = import ./git-replace.nix { pkgs = prev; };
        herdr = herdr.packages.${system}.default;
        huddly = import ./huddly.nix;
        huddly-cli = import ./huddly-cli.nix { pkgs = prev; };
        refresh-display = import ./refresh-display.nix { pkgs = prev; };
        set-dpi = import ./set-dpi.nix { pkgs = prev; };
        sof-firmware = with prev; import ./sof-firmware.nix { inherit fetchurl lib stdenvNoCC; };
        spec = import ./spec.nix {
          pkgs = prev;
          inherit (final) agent;
        };
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
