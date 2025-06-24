{ lib, pkgs, ... }:

let
  bolder-sounds = pkgs.stdenv.mkDerivation {
    name = "bolder-sounds";

    src = pkgs.requireFile {
      name = "bolder-sounds.tar.gz";
      url = "bolder-sounds.tar.gz";
      sha256 = "0p93l3nls8x8a70b5g6fpsrki8f12xdblvrp6fhzjss6ps57harb";
    };

    installPhase = ''
      mkdir -p $out/share/sfz/bolder-sounds
      cp -a * $out/share/sfz/bolder-sounds
    '';
  };
  digital-sound-factory = pkgs.stdenv.mkDerivation {
    name = "digital-sound-factory";

    src = pkgs.requireFile {
      name = "digital-sound-factory.tar.gz";
      url = "digital-sound-factory.tar.gz";
      sha256 = "0r7vsifk8apy4ywnr11sc1rr3sf3iqx8gv18f990hdbn81spmvbf";
    };

    installPhase = ''
      mkdir -p $out/share/soundfonts/digital-sound-factory
      cp -a * $out/share/soundfonts/digital-sound-factory
    '';
  };
  ivy-audio = pkgs.stdenv.mkDerivation {
    name = "ivy-audio";

    src = pkgs.requireFile {
      name = "ivy-audio.tar.gz";
      url = "ivy-audio.tar.gz";
      sha256 = "1lyi254srlgmyyzgd0lyd5ybcgw13pankw7s0nk83afjgp3hmfmx";
    };

    installPhase = ''
      mkdir -p $out/share/sfz/ivy-audio
      cp -a * $out/share/sfz/ivy-audio
    '';
  };
  samples-from-mars = pkgs.stdenv.mkDerivation {
    name = "samples-from-mars";

    src = pkgs.requireFile {
      name = "samples-from-mars.tar.gz";
      url = "samples-from-mars.tar.gz";
      sha256 = "1zndas1akl75yx2x201ngs2dcj148mhja7b5j1vf1sqrx3jidfvr";
    };

    installPhase = ''
      mkdir -p $out/share/sfz/samples-from-mars
      cp -a * $out/share/sfz/samples-from-mars
    '';
  };
in {
  home = {
    file = {
      "studio/ir/lexicon-lxp-1-impulse-responses".source = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "evenbrenden";
        repo = "lexicon-lxp-1-impulse-responses";
        rev = "61d7c66813b9d4305297b0a9b7c62beacd4a9dac";
        hash = "sha256-IvSuKYpcdYK8/9AHM5O88ATY3vkiUEczIWZgT0QCIhU=";
      };
      "studio/midi/instant-midi-drum-patterns".source = pkgs.fetchzip {
        url = "https://web.archive.org/web/20190305092857/http://www.fivepinpress.com/InstantDrumPatterns.zip";
        sha256 = "sha256-mklEKxQ5DlRzuvw4QvR20SRp/zGGOUadClk1keBqdy8=";
      };
      "studio/sfz/ac-upright".source = fetchGit {
        url = "git@github.com:evenbrenden/ac-upright.git";
        rev = "907ee4f1dc66ee1375a7bcd7fd47f58ab2105f62";
      };
      "studio/sfz/bolder-sounds".source = "${bolder-sounds}/share/sfz/bolder-sounds";
      "studio/sfz/dsmolken-double-bass".source = pkgs.fetchFromGitHub {
        owner = "sfzinstruments";
        repo = "dsmolken.double-bass";
        rev = "v1.001";
        sha256 = "sha256-KC/uqQhr47xyalGbTuFaw63vhNZssssWeuwl9leD8nc=";
      };
      "studio/sfz/fretls-dry".source = fetchGit {
        url = "git@github.com:evenbrenden/fretls-dry.git";
        rev = "cf80dd097a587668494877b20f409729f629c4f6";
      };
      "studio/sfz/ivy-audio".source = "${ivy-audio}/share/sfz/ivy-audio";
      "studio/sfz/jsteeldrum".source = pkgs.fetchFromGitHub {
        owner = "sfzinstruments";
        repo = "jlearman.SteelDrum";
        rev = "e429428dd65dc645e4c9b1f134da4d2e40c400c6";
        sha256 = "sha256-zLLskiJF8D2tR5gN2Yok4c2jFLUm5SZwEODaTtxRXmo=";
      };
      "studio/sfz/samples-from-mars".source = "${samples-from-mars}/share/sfz/samples-from-mars";
      "studio/sfz/virtuosity-drums".source = pkgs.fetchFromGitHub {
        owner = "sfzinstruments";
        repo = "virtuosity_drums";
        rev = "v0.924";
        sha256 = "sha256-kedn/auowOdejv0CE97Xvc3t7tkaIqnYEk0KtNO+Md4=";
      };
      "studio/sfz/wet-fretls".source = fetchGit {
        url = "git@github.com:evenbrenden/wet-fretls.git";
        rev = "bd5cb6659e4f7a917c34d7695bf9156090a6ead1";
      };
      "studio/sfz/yamaha-tx81z-lately-bass".source = pkgs.fetchzip {
        url = "http://www.tiltshiftgallery.se/audio/yamaha_tx81z_lately_bass.zip";
        sha256 = "sha256-KViSOLl3+M1VYWE+i2Y38jJK8SuNS56eHhKb8wkwGTA=";
      };
      "studio/soundfonts/digital-sound-factory".source =
        "${digital-sound-factory}/share/soundfonts/digital-sound-factory";
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
