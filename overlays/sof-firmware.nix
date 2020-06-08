(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {
      pname = "sof-firmware";
      version = "1.5";

      src = super.fetchzip {
        url = "https://github.com/thesofproject/sof-bin/archive/stable-v${version}.zip";
        sha256 = "11vs7ncsysj77j6s9dskyxbbx92kz9xf003p5gdxxql5l9m7fqkw";
      };

      installPhase = ''
        mkdir -p $out/lib/firmware/intel

        ROOT=$out
        INTEL_PATH=lib/firmware/intel
        VERSION=v${version}

        echo "Installing Intel firmware and topology $VERSION to $INTEL_PATH"

        # wipe previous releases
        rm -rf ''${ROOT}/''${INTEL_PATH}/sof/*
        rm -rf ''${ROOT}/''${INTEL_PATH}/sof-tplg-*
        rm -rf ''${ROOT}/''${INTEL_PATH}/sof-tplg

        # copy to destination
        cd lib/firmware
        cp -rf intel ''${ROOT}/lib/firmware

        # add symlinks
        cd ''${ROOT}/''${INTEL_PATH}/sof

        ln -s ''${VERSION}/sof-bdw-''${VERSION}.ri sof-bdw.ri
        ln -s ''${VERSION}/sof-byt-''${VERSION}.ri sof-byt.ri
        ln -s ''${VERSION}/sof-cht-''${VERSION}.ri sof-cht.ri
        ln -s ''${VERSION}/intel-signed/sof-apl-''${VERSION}.ri sof-apl.ri
        ln -s ''${VERSION}/intel-signed/sof-apl-''${VERSION}.ri sof-glk.ri
        ln -s ''${VERSION}/intel-signed/sof-cnl-''${VERSION}.ri sof-cfl.ri
        ln -s ''${VERSION}/intel-signed/sof-cnl-''${VERSION}.ri sof-cnl.ri
        ln -s ''${VERSION}/intel-signed/sof-cnl-''${VERSION}.ri sof-cml.ri
        ln -s ''${VERSION}/intel-signed/sof-icl-''${VERSION}.ri sof-icl.ri

        cd ..
        ln -s sof-tplg-''${VERSION} sof-tplg

        echo "Done installing Intel firmware and topology ''$VERSION"
      '';
    });
  }
)
