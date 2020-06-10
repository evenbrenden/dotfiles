(self: super:
  {
    alsa-ucm-conf = super.alsa-ucm-conf.overrideAttrs (_: {
      nativeBuildInputs = [ super.git ];

      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/alsa
        cp -r ucm ucm2 $out/share/alsa

        git apply ${./x1c7.patch}

        runHook postInstall
      '';
    });
  }
)
