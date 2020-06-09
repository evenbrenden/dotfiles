(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {
      pname = "sof-firmware";
      version = "1.5";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "e6d11bf44f0c7ad6032d201e753aa254bb075ee7";
        sha256 = "11vs7ncsysj77j6s9dskyxbbx92kz9xf003p5gdxxql5l9m7fqkw";
      };

      installPhase = ''
        mkdir -p $out/lib/firmware/intel

        ROOT=$out
        INTEL_PATH=lib/firmware/intel
        VERSION=v${version}

        echo "Installing Intel firmware and topology $VERSION to $INTEL_PATH"

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
