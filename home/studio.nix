{ lib, pkgs, ... }:

{
  home = {
    file = {
      "studio/ir/lexicon-lxp-1-impulse-responses".source =
        "${pkgs.lexicon-lxp-1-impulse-responses}/share/ir/lexicon-lxp-1-impulse-responses";
      "studio/midi/instant-midi-drum-patterns".source =
        "${pkgs.instant-midi-drum-patterns}/share/midi/instant-midi-drum-patterns";
      "studio/sfz/ac-upright".source = "${pkgs.ac-upright}/share/sfz/ac-upright";
      "studio/sfz/dsmolken-double-bass".source = "${pkgs.dsmolken-double-bass}/share/sfz/dsmolken-double-bass";
      "studio/sfz/fretls-dry".source = "${pkgs.fretls-dry}/share/sfz/fretls-dry";
      "studio/sfz/jsteeldrum".source = "${pkgs.jsteeldrum}/share/sfz/jsteeldrum";
      "studio/sfz/virtuosity-drums".source = "${pkgs.virtuosity-drums}/share/sfz/virtuosity-drums";
      "studio/sfz/wet-fretls".source = "${pkgs.wet-fretls}/share/sfz/wet-fretls";
      "studio/sfz/yamaha-tx81z-lately-bass".source =
        "${pkgs.yamaha-tx81z-lately-bass}/share/sfz/yamaha-tx81z-lately-bass";
      "studio/soundfonts/FluidR3_GM2-2.sf2".source = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
    };
    packages = [ pkgs.carla pkgs.reaper pkgs.sfizz ];
    sessionVariables = {
      LV2_PATH = lib.strings.concatStringsSep ":" [ "${pkgs.carla}/lib/lv2" "${pkgs.sfizz}/lib/lv2" ];
      UHE_RT_PRIO = 64; # For u-he plugins
      VST_PATH = builtins.concatStringsSep ":" [
        "$HOME/.vst" # For u-he plugins
        "${pkgs.carla}/lib/vst"
      ];
      VST3_PATH = builtins.concatStringsSep ":" [
        "$HOME/.vst3" # For u-he plugins
        "${pkgs.sfizz}/lib/vst3"
      ];
    };
  };

  xdg.desktopEntries.ft2-clone = {
    name = "Fasttracker II clone";
    exec = "${pkgs.ft2-clone}/bin/ft2-clone";
  };
}
