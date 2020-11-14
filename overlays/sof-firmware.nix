(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {
      pname = "sof-firmware";
      version = "1.6";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "47b436af36c18c3b4f409e1d9452aea18e17abc8";
        sha256 = "19kvzlhjzznr9g8w3kxkigax5h75wmig9q5swwfz3nc2h6yyr8jf";
      };

      installPhase = ''
        mkdir -p $out/lib/firmware
        patchShebangs go.sh
        ROOT=$out SOF_VERSION=v${version} ./go.sh
      '';
    });
  }
)
