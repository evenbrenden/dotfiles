(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.1.3";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1zzkd3b5j3q6jqrvibxz33a4fcm7pgqfx91bqjs615v3499ncng7";
        };
      });
    };
  }
)
