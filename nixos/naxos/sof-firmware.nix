# https://github.com/NixOS/nixpkgs/pull/150512
(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {

      version = "1.9.3";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "v${version}";
        sha256 = "0dpwpk91xhawpjc2lyq0748ln822z30wn18pcyylp3ph95rv00cr";
      };
    });
  }
)
