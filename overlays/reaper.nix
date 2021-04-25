(self: super:
  {
    reaper = super.reaper.overrideAttrs (_: rec {

      pname = "reaper";
      version = "6.28";

      src = super.fetchurl {
        url = "https://www.reaper.fm/files/${super.lib.versions.major version}.x/reaper${builtins.replaceStrings ["."] [""] version}_linux_x86_64.tar.xz";
        sha256 = "07lr20dr1xjbhg0qrrdk63f0zwwzrfkdbsp863rn6hdb3y6x5hfz";
      };
    });
  }
)
