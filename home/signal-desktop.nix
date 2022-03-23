(self: super: {
  signal-desktop = super.signal-desktop.overrideAttrs (_: rec {
    pname = "signal-desktop";
    version = "5.35.0";

    src = super.fetchurl {
      url =
        "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_${version}_amd64.deb";
      sha256 = "sha256-2KF2OLq6/vHElgloxn+kgQisJC+HAkpOBfsKfEPW35c=";
    };
  });
})
