(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.3.3";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1sl3dd104d9i5yvww5rn9isjvp69vdvklm1qh16fx5dpdrin9ys9";
        };
      });
    };
  }
)
