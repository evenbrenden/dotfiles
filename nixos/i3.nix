(self: super: {
  i3 = super.i3.overrideAttrs (_: rec {
    pname = "i3";
    version = "4.22";

    src = super.fetchurl {
      url = "https://i3wm.org/downloads/${pname}-${version}.tar.xz";
      sha256 = "sha256-KGOZEeWdlWOfCSZCqYL14d6lkiUMK1zpjtoQCDNRPks=";
    };
  });
})
