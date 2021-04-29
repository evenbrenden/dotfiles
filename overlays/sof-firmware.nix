(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {

      version = "1.7";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "v${version}";
        sha256 = "sha256-Z0Z4HLsIIuW8E1kFNhAECmzj1HkJVfbEw13B8V7PZLk=";
      };

      installPhase = ''
        mkdir -p $out/lib/firmware/intel/
        cp -a sof-v${version} $out/lib/firmware/intel/sof
        cp -a sof-tplg-v${version} $out/lib/firmware/intel/sof-tplg
      '';
    });
  }
)
