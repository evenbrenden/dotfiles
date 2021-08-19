(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2021.1.5";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "sha256:17mxqh6p9jby5qrjqaq5km0j8k1bp8061ch2j059ka3n4ycxy7ph";
        };
      });
    };
  }
)
