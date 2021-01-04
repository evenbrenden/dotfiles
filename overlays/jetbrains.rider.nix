(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.3.2";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1dkgbd2nqkjcswf7j3pnrsaq9n5wk42abz2c4wgkrh1zrpgihd0j";
        };
      });
    };
  }
)
