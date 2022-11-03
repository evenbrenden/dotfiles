(self: super: {
  discord = super.discord.overrideAttrs (_: rec {
    pname = "discord";
    version = "0.0.21";

    src = super.fetchurl {
      url =
        "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "sha256-KDKUssPRrs/D10s5GhJ23hctatQmyqd27xS9nU7iNaM=";
    };
  });
})
