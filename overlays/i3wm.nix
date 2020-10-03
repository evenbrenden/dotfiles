(self: super:
  {
    i3 = super.i3.overrideAttrs (_: rec {
      pname = "i3";
      version = "4.18.1";

      src = super.fetchurl {
        url = "https://i3wm.org/downloads/${pname}-${version}.tar.bz2";
        sha256 = "0z709cianlzw0x0qwq4361347354xd9ckj1v7vjvhb1zh3x91gws";
      };
    });
  }
)
