(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.2.2";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1v3n4mg8b55ni72bdgsgiwyqcvp9zhqlkqshscwfjggv0iai9r6p";
        };
      });
    };
  }
)
