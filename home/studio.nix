{ config, pkgs, ... }:

{
  home = {
    file = {
      "studio/ir".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/${config.home.username}/share/ir";
      "studio/midi".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/${config.home.username}/share/midi";
      "studio/sfz".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/${config.home.username}/share/sfz";
      "studio/soundfonts".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/profiles/per-user/${config.home.username}/share/soundfonts";
    };
    packages = with pkgs; [
      ac-upright
      bolder-sounds
      carla
      digital-sound-factory
      dsmolken-double-bass
      fretls-dry
      instant-midi-drum-patterns
      ivy-audio
      jsteeldrum
      lexicon-lxp-1-impulse-responses
      reaper
      samples-from-mars
      sfizz
      soundfont-fluid
      virtuosity-drums
      wet-fretls
      yamaha-tx81z-lately-bass
    ];
    sessionVariables = {
      LV2_PATH = "/etc/profiles/per-user/${config.home.username}/lib/lv2";
      UHE_RT_PRIO = 64; # For u-he plugins
      VST_PATH = builtins.concatStringsSep ":" [
        "$HOME/.vst" # For u-he plugins
        "/etc/profiles/per-user/${config.home.username}/lib/vst"
      ];
      VST3_PATH = builtins.concatStringsSep ":" [
        "$HOME/.vst3" # For u-he plugins
        "/etc/profiles/per-user/${config.home.username}/lib/vst3"
      ];
    };
  };

  xdg.desktopEntries.ft2-clone = {
    name = "Fasttracker II clone";
    exec = "${pkgs.ft2-clone}/bin/ft2-clone";
  };
}
