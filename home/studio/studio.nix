{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    let
      locals = [
        (import ./bolder-sounds.nix { inherit pkgs; })
        (import ./digital-sound-factory.nix { inherit pkgs; })
        (import ./ivy-audio.nix { inherit pkgs; })
        (import ./samples-from-mars.nix { inherit pkgs; })
      ];
      remotes = [
        (import ./ac-upright.nix { inherit pkgs; })
        carla
        (import ./dsmolken-double-bass.nix { inherit pkgs; })
        (import ./fretls-dry.nix { inherit pkgs; })
        (import ./instant-midi-drum-patterns.nix { inherit pkgs; })
        (import ./jsteeldrum.nix { inherit pkgs; })
        (import ./lexicon-lxp-1-impulse-responses.nix { inherit pkgs; })
        reaper
        sfizz
        soundfont-fluid
        (import ./virtuosity-drums.nix { inherit pkgs; })
        (import ./wet-fretls.nix { inherit pkgs; })
        (import ./yamaha-tx81z-lately-bass.nix { inherit pkgs; })
      ];
    in locals ++ remotes;

  # Because some types of resources do not have established environment variables (like SFZ_PATH)
  # that plugins can use to look up locations, we link them to the home directory for easy access.
  home.file = {
    "studio/ir".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/ir"; # Broken!
    "studio/midi".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/midi"; # Broken!
    "studio/sfz".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/sfz"; # Broken!
    "studio/soundfonts".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/soundfonts"; # Broken!
  };

  xdg.desktopEntries.ft2-clone = {
    name = "Fasttracker II clone";
    exec = "${pkgs.ft2-clone}/bin/ft2-clone";
  };

  home.sessionVariables = {
    DSSI_PATH = "$HOME/.dssi:/etc/profiles/per-user/evenbrenden/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:/etc/profiles/per-user/evenbrenden/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH = "$HOME/.lv2:/etc/profiles/per-user/evenbrenden/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH = "$HOME/.lxvst:/etc/profiles/per-user/evenbrenden/lib/lxvst:/run/current-system/sw/lib/lxvst";
    UHE_RT_PRIO = 64; # For u-he plugins
    VST_PATH = "$HOME/.vst:/etc/profiles/per-user/evenbrenden/lib/vst:/run/current-system/sw/lib/vst";
    VST3_PATH = "$HOME/.vst3:/etc/profiles/per-user/evenbrenden/lib/vst3:/run/current-system/sw/lib/vst3";
  };
}
