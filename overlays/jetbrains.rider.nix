(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.3-EAP9-203.5981.21.Checked";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1nwx8gd8fbpz9lii98wbhwymx8jbb0yxbn7i0mh4df5180g65pj3";
        };
      });
    };
  }
)
