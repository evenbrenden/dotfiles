let
  version = "2019.3.4";
in
(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: {
        name = "rider-${version}";
        version = "${version}";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "17axv0v31dpmjcaij5qpqqm071mwhmf1ahy0y0h96limq8cw9872";
        };
      });
    };
  }
)
