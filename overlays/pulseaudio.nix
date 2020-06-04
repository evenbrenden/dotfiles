(self: super:
  {
    pulseaudio = super.callPackage
      ({ libOnly ? false }:

      super.pulseaudio.overrideAttrs (_: rec {
        name = "${if libOnly then "lib" else ""}pulseaudio-${version}";
        version = "13.99";

        src = super.fetchurl {
          url = "http://freedesktop.org/software/pulseaudio/releases/pulseaudio-${version}.1.tar.xz";
          sha256 = "030a7v0khp6w683km81c6vpch1687pvx2gvscnzkjq4f0z6138g6";
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
