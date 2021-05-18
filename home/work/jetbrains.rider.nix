(self: super:
  {
    jetbrains = super.jetbrains // {
      rider = super.jetbrains.rider.overrideDerivation (_: rec {
        name = "rider-${version}";
        version = "2021.1.2";

        src = super.fetchurl {
          url = "https://download.jetbrains.com/rider/JetBrains.Rider-${version}.tar.gz";
          sha256 = "1a28pi18j0cb2wxhw1vnfg9gqsgf2kyfg0hl4xgqp50gzv7i3aam";
        };

        # https://github.com/NixOS/nixpkgs/pull/120589
        patchPhase = ''
          rm -rf lib/ReSharperHost/linux-x64/dotnet
          mkdir -p lib/ReSharperHost/linux-x64/dotnet/
          ln -s ${super.dotnet-sdk_5}/bin/dotnet lib/ReSharperHost/linux-x64/dotnet/dotnet
        '';
      });
    };
  }
)
