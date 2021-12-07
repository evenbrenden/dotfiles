# https://github.com/NixOS/nixpkgs/pull/130884
(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {

      version = "1.9.2";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "v${version}";
        sha256 = "sha256-aEoLlP34rorllCdTneATlCHnmhJD/VABV9Uv4dDmShA=";
      };
    });
  }
)
