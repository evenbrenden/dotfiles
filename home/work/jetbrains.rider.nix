(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2021.2.2";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "17xx8mz3dr5iqlr0lsiy8a6cxz3wp5vg8z955cdv0hf8b5rncqfa";
        };
      });
    };
  }
)
