(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.3.4";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1v99yqj83aw9j400z3v24n7xnyxzw5vm0b3rwd4yb8w3ajl59gq1";
        };
      });
    };
  }
)
