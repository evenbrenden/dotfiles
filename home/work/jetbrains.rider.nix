(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2021.1.3";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "0k2vpndpachq6g767v2dwfa3xc8mssv0i7wwpm05dgqirpn4n0dw";
        };
      });
    };
  }
)
