(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {
      pname = "sof-firmware";
      version = "1.4.2";

      src = super.fetchzip {
        url = "https://github.com/thesofproject/sof-bin/archive/stable-v${version}.zip";
        sha256 = "0djkqb8lgyql78pv9mcnda0i3lkjk1whk9ai5gzrz1p68dyppjc9";
      };

      installPhase = ''
        mkdir -p $out/lib/firmware/intel
        substituteInPlace go.sh --replace 'ROOT=' 'ROOT=$out'
        ./go.sh
      '';
    });
  }
)
