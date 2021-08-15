(self: super:
  {
    signal-desktop = super.signal-desktop.overrideAttrs (_: rec {
      pname = "signal-desktop";
      version = "5.13.1";

      src = super.fetchurl {
        url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
        sha256 = "0k3gbs6y19vri5n087wc6fdhydkis3h6rhxd3w1j9rhrb5fxjv3q";
      };
    });
  }
)
