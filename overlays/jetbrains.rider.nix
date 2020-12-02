(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.2.4";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1anl48ifv5ayqn876dqckxc1b5fw1271pvamzf1vvk501wv6dpaf";
        };
      });
    };
  }
)
