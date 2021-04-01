(self: super:
  {
    reaper = super.reaper.overrideAttrs (_: rec {

      pname = "reaper";
      version = "6.26";

      src = super.fetchurl {
        url = "https://www.reaper.fm/files/${super.lib.versions.major version}.x/reaper${builtins.replaceStrings ["."] [""] version}_linux_x86_64.tar.xz";
        sha256 = "0a7kznj0qn27r5313jrgcr2fqf7njgd4b0p2yh0brrwd7j2bw50k";
      };
    });
  }
)
