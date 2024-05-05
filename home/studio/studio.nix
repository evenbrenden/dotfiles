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
    "studio/ir".source = config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/evenbrenden/share/ir";
    "studio/midi".source = config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/evenbrenden/share/midi";
    "studio/sfz".source = config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/evenbrenden/share/sfz";
    "studio/soundfonts".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/evenbrenden/share/soundfonts";
  };

  xdg.desktopEntries.ft2-clone = {
    name = "Fasttracker II clone";
    exec = "${pkgs.ft2-clone}/bin/ft2-clone";
  };

  home.sessionVariables = {
    LV2_PATH = builtins.concatStringsSep ":" [ "$HOME/.lv2" "/etc/profiles/per-user/evenbrenden/lib/lv2" ];
    UHE_RT_PRIO = 64; # For u-he plugins
    VST_PATH = builtins.concatStringsSep ":" [ "$HOME/.vst" "/etc/profiles/per-user/evenbrenden/lib/vst" ];
    VST3_PATH = builtins.concatStringsSep ":" [ "$HOME/.vst3" "/etc/profiles/per-user/evenbrenden/lib/vst3" ];
  };
}
