(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {
      pname = "sof-firmware";
      version = "1.6";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "cbdec6963b2c2d58b0080955d3c11b96ff4c92f0";
        sha256 = "0la2pw1zpv50cywiqcfb00cxqvjc73drxwjchyzi54l508817nxh";
      };

      installPhase = ''
        mkdir -p $out/lib/firmware
        patchShebangs go.sh
        ROOT=$out SOF_VERSION=v${version} ./go.sh
      '';
    });
  }
)
