{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
  ];

  nixpkgs.overlays = [
    (import ../../overlays/reaper.nix) # 6.26
  ];

  home.packages = with pkgs;
    let
      fluidsynth-220 = pkgs.fluidsynth.overrideAttrs (_: rec {

        name = "fluidsynth-${version}";
        version = "2.2.0";

        src = pkgs.fetchFromGitHub {
          owner = "FluidSynth";
          repo = "fluidsynth";
          rev = "v${version}";
          sha256 = "1769aqkw2hv9yfazyd8pmbfhyjk8k8bgdr63fz5w8zgr4n38cgqm";
        };
      });
    in [

    # Plugins
    (carla.override { fluidsynth = fluidsynth-220; }) # For SoundFonts (FluidSynth)
    lsp-plugins # For IR plugins
    sfizz

    # Programs
    polyphone
    reaper
    (renoise.override {
        releasePath = builtins.fetchTarball {
          url = "file://${builtins.toString ./.}/rns_324_linux_x86_64.tar.gz";
          sha256 = "0jwk9z62kk5dk95cbqasjrbag0qwvl2lix5k0pd98dmx05lxvbi5";
        };
      }
    )
  ];

  # Terrible workaround until I can figure out how to make the desktop item
  # supplied with the Renoise tarball to work when installed via the package
  xdg.dataFile."applications/renoise.desktop".source = ./renoise.desktop;
}
