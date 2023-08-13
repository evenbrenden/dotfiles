{ pkgs, ... }:

{
  home.packages = with pkgs;
    let
      plugins = [
        carla
        (import ./fretls.nix { inherit pkgs; })
        (import ./impulse-responses.nix { inherit pkgs; })
        (import ./instruments.nix { inherit pkgs; })
        (import ./midi.nix { inherit pkgs; })
        sfizz
        (import ./virtuosity-drums.nix { inherit pkgs; })
        (import ./yamaha-tx81z-lately-bass.nix { inherit pkgs; })
      ];
      programs = [ reaper ];
    in plugins ++ programs;

  xdg.desktopEntries.ft2-clone = {
    name = "Fasttracker II clone";
    exec = "${pkgs.ft2-clone}/bin/ft2-clone";
  };

  home.sessionVariables = {
    DSSI_PATH = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    UHE_RT_PRIO = 64; # For u-he plugins
    VST_PATH = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
    VST3_PATH = "$HOME/.vst3:$HOME/.nix-profile/lib/vst3:/run/current-system/sw/lib/vst3";
  };
}
