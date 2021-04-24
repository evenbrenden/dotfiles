(self: super:
  {
    calf = super.calf.overrideAttrs (_: rec {
      # https://github.com/calf-studio-gear/calf/issues/289
      configureFlags = [
        "--enable-shared"
        "--disable-static"
        "--enable-experimental"
      ];
    });
  }
)
