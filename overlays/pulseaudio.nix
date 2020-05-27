(self: super:
  {
    pulseaudio = super.pulseaudio.overrideAttrs (_: rec {
      name = super.pulseaudio.name;
      version = "13.99";

      src = super.fetchurl {
        url = "http://freedesktop.org/software/pulseaudio/releases/pulseaudio-${version}.1.tar.xz";
        sha256 = "030a7v0khp6w683km81c6vpch1687pvx2gvscnzkjq4f0z6138g6";
      };

      postInstall = super.pulseaudio.postInstall;
    });
  }
)
