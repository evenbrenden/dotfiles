(self: super:
  {
    xautolock = super.xautolock.overrideAttrs (_: rec {

      src = super.fetchFromGitHub {
        owner = "evenbrenden";
        repo = "xautolock";
        rev = "7f6bec67a1493b5353f01e791c3124a5eb7f60be";
        sha256 = "04xkf01hxf92xgqrzma9lvvhkjai81aczwii19zdr1pmmapcv08q";
      };
    });
  }
)
