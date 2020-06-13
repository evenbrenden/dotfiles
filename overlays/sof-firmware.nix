(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {
      pname = "sof-firmware";
      version = "1.5.1";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "ae61d2778b0a0f47461a52da0d1f191f651e0763";
        sha256 = "0j6bpwz49skvdvian46valjw4anwlrnkq703n0snkbngmq78prba";
      };

      installPhase = ''
        mkdir -p $out/lib/firmware/intel
        substituteInPlace go.sh \
          --replace 'ROOT=' 'ROOT=$out' \
          --replace 'VERSION=$(git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3| cut -d"-" -f 2)' 'VERSION=v${version}'
        ./go.sh
      '';
    });
  }
)
