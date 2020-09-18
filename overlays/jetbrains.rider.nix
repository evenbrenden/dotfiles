(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2020.2.1";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "0xrk7n0mprzy7dfkx3vj5wasw5031jl61qkh89y6w031hp77vq7n";
        };
      });
    };
  }
)
