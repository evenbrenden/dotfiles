{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
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
    calf
    (carla.override { fluidsynth = fluidsynth-220; })
    sfizz

    # Programs
    polyphone
    (callPackage (import ./reaper.nix) {})
  ];

  home.sessionVariables = {
    DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH    = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
    VST3_PATH   = "$HOME/.vst3:$HOME/.nix-profile/lib/vst3:/run/current-system/sw/lib/vst3";
  };
}
