{ pkgs, ... }:

{
  home = {
    file = {
      ".lv2/carla.lv2".source = "${pkgs.carla}/lib/lv2/carla.lv2";
      ".lv2/sfizz.lv2".source = "${pkgs.sfizz}/lib/lv2/sfizz.lv2";
      ".vst/carla.vst".source = "${pkgs.carla}/lib/vst/carla.vst";
      ".vst3/sfizz.vst3".source = "${pkgs.sfizz}/lib/vst3/sfizz.vst3";
    };
    packages = [ pkgs.carla pkgs.reaper pkgs.sfizz ];
    sessionVariables.UHE_RT_PRIO = 64;
  };

  xdg = {
    configFile."REAPER/Configurations/reaper.ReaperConfigZip".source = ./dotfiles/reaper.ReaperConfigZip;
    dataFile = {
      "impulse-responses/lexicon-lxp-1-impulse-responses".source = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "evenbrenden";
        repo = "lexicon-lxp-1-impulse-responses";
        rev = "61d7c66813b9d4305297b0a9b7c62beacd4a9dac";
        hash = "sha256-IvSuKYpcdYK8/9AHM5O88ATY3vkiUEczIWZgT0QCIhU=";
      };
      "midi/instant-midi-drum-patterns".source = pkgs.fetchzip {
        url = "https://web.archive.org/web/20190305092857/http://www.fivepinpress.com/InstantDrumPatterns.zip";
        sha256 = "sha256-mklEKxQ5DlRzuvw4QvR20SRp/zGGOUadClk1keBqdy8=";
      };
      "sfz/ac-upright".source = fetchGit {
        url = "git@github.com:evenbrenden/ac-upright.git";
        rev = "907ee4f1dc66ee1375a7bcd7fd47f58ab2105f62";
      };
      "sfz/dsmolken-double-bass".source = pkgs.fetchFromGitHub {
        owner = "sfzinstruments";
        repo = "dsmolken.double-bass";
        rev = "v1.001";
        sha256 = "sha256-KC/uqQhr47xyalGbTuFaw63vhNZssssWeuwl9leD8nc=";
      };
      "sfz/fretls-dry".source = fetchGit {
        url = "git@github.com:evenbrenden/fretls-dry.git";
        rev = "cf80dd097a587668494877b20f409729f629c4f6";
      };
      "sfz/jsteeldrum".source = pkgs.fetchFromGitHub {
        owner = "sfzinstruments";
        repo = "jlearman.SteelDrum";
        rev = "e429428dd65dc645e4c9b1f134da4d2e40c400c6";
        sha256 = "sha256-zLLskiJF8D2tR5gN2Yok4c2jFLUm5SZwEODaTtxRXmo=";
      };
      "sfz/virtuosity-drums".source = pkgs.fetchFromGitHub {
        owner = "sfzinstruments";
        repo = "virtuosity_drums";
        rev = "v0.924";
        sha256 = "sha256-kedn/auowOdejv0CE97Xvc3t7tkaIqnYEk0KtNO+Md4=";
      };
      "sfz/wet-fretls".source = fetchGit {
        url = "git@github.com:evenbrenden/wet-fretls.git";
        rev = "bd5cb6659e4f7a917c34d7695bf9156090a6ead1";
      };
      "sfz/yamaha-tx81z-lately-bass".source = pkgs.fetchzip {
        url = "http://www.tiltshiftgallery.se/audio/yamaha_tx81z_lately_bass.zip";
        sha256 = "sha256-KViSOLl3+M1VYWE+i2Y38jJK8SuNS56eHhKb8wkwGTA=";
      };
      "soundfonts/FluidR3_GM2-2.sf2".source = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
    };
    desktopEntries.ft2-clone = {
      name = "Fasttracker II clone";
      exec = "${pkgs.ft2-clone}/bin/ft2-clone";
    };
  };
}
