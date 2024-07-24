{ pkgs }:

pkgs.signal-desktop.overrideAttrs (_: rec {
  version = "7.16.0";
  src = pkgs.fetchurl {
    url = "https://updates.signal.org/desktop/apt/pool/s/signal-desktop/signal-desktop_${version}_amd64.deb";
    hash = "sha256-DfPQb3TGhVVZ7webNoMmyhjhRKKO3lWf12ZIpi7D7tc=";
  };
})
