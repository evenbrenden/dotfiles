(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.2.3";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "01namzd29chj975w3awanlzf38hh30cfjzyljqfkp6y3djn0if1r";
        };
      });
    };
  }
)
