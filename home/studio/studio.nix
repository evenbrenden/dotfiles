{ pkgs, ... }:

{
  home.packages = with pkgs;
    let
      plugins = [ carla sfizz ];
      programs = [ reaper ];
    in plugins ++ programs;

  # Because some types of resources do not have established environment variables (like SFZ_PATH)
  # that plugins can use to look up locations (like ~/.nix-profile/share/sfz), we link them
  # directly to the home directory for easy access.
  home.file = let
    requirezip = import ./requirezip.nix;
    irPath = "studio/ir";
    sf2Path = "studio/sf2";
    sfzPath = "studio/sfz";
  in {
    "${irPath}/lexicon-lxp-1-impulse-responses".source = pkgs.fetchFromGitea {
      domain = "codeberg.org";
      owner = "evenbrenden";
      repo = "lexicon-lxp-1-impulse-responses";
      rev = "61d7c66813b9d4305297b0a9b7c62beacd4a9dac";
      hash = "sha256-IvSuKYpcdYK8/9AHM5O88ATY3vkiUEczIWZgT0QCIhU=";
    };
    "${sf2Path}/digital-sound-factory".source = requirezip {
      inherit pkgs;
      url = "digital-sound-factory.tar.gz";
      sha256 = "0r7vsifk8apy4ywnr11sc1rr3sf3iqx8gv18f990hdbn81spmvbf";
    };
    "${sfzPath}/fretls".source = fetchGit {
      url = "git@github.com:evenbrenden/fretls.git";
      rev = "0f00a4eaa2d6d49ca9ac96e3e80457482f158888";
    };
    "${sfzPath}/samples-from-mars".source = requirezip {
      inherit pkgs;
      url = "samples-from-mars.tar.gz";
      sha256 = "1zndas1akl75yx2x201ngs2dcj148mhja7b5j1vf1sqrx3jidfvr";
    };
    "${sfzPath}/virtuosity-drums".source = pkgs.fetchFromGitHub {
      owner = "sfzinstruments";
      repo = "virtuosity_drums";
      rev = "v0.924";
      sha256 = "sha256-kedn/auowOdejv0CE97Xvc3t7tkaIqnYEk0KtNO+Md4=";
    };
    "${sfzPath}/yamaha-tx81z-lately-bass".source = pkgs.fetchzip {
      url = "http://www.tiltshiftgallery.se/audio/yamaha_tx81z_lately_bass.zip";
      sha256 = "sha256-KViSOLl3+M1VYWE+i2Y38jJK8SuNS56eHhKb8wkwGTA=";
    };
  };

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
