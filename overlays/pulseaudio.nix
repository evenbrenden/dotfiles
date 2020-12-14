(self: super:
  {
    pulseaudio = super.callPackage
      ({ libOnly ? false, ... }@args:

      (super.pulseaudio.override args).overrideAttrs (_: rec {
        name = "${if libOnly then "lib" else ""}pulseaudio-${version}";
        version = "14.0";

        src = super.fetchurl {
          url = "http://freedesktop.org/software/pulseaudio/releases/pulseaudio-${version}.tar.xz";
          sha256 = "0qf20rgg0ysrnvg3359j56ndls07qmfn5rsy9r85bc42jdfpfd58";
        };

        postInstall = super.lib.optionalString libOnly ''
          rm -rf $out/{bin,share,etc,lib/{pulse-*,systemd}}
          sed 's|-lltdl|-L${super.libtool.lib}/lib -lltdl|' -i $out/lib/pulseaudio/libpulsecore-${version}.la
        ''
          + ''
          moveToOutput lib/cmake "$dev"
          rm -f $out/bin/qpaeq # this is packaged by the "qpaeq" package now, because of missing deps
        '';
      }))
    {};
  }
)
