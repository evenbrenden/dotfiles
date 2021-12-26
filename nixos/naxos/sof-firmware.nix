# https://github.com/NixOS/nixpkgs/pull/152240
(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {

      version = "2.0";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "v${version}";
        sha256 = "sha256-pDxNcDe/l1foFYuHB0w3YZidKIeH6h0IuwRmMzeMteE=";
      };
    });
  }
)
