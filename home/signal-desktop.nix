(self: super:
  {
    signal-desktop = super.signal-desktop.overrideAttrs (_: rec {
      pname = "signal-desktop";
      version = "5.22.0";

      src = super.fetchurl {
        url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
        sha256 = "1y88qw57wk187fjb05zqvagv4pamc8171xwvznqb2k0vclsg82j8";
      };
    });
  }
)
