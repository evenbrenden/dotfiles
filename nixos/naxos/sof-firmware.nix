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

      installPhase = ''
        cd "v${super.lib.versions.majorMinor version}.x"
        mkdir -p $out/lib/firmware/intel/
        cp -a sof-v${version} $out/lib/firmware/intel/sof
        cp -a sof-tplg-v${version} $out/lib/firmware/intel/sof-tplg
        runHook postInstall
      '';
    });
  }
)
