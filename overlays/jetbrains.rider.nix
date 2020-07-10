(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.1.4";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "0vicgwgsbllfw6fz4l82x4vbka3agf541576ix9akyvsskwbaxj9";
        };
      });
    };
  }
)
