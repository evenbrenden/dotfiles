# https://github.com/NixOS/nixpkgs/pull/183856
(self: super: {
  sof-firmware = super.sof-firmware.overrideAttrs (_: rec {
    version = "2.2";
    src = super.fetchFromGitHub {
      owner = "thesofproject";
      repo = "sof-bin";
      rev = "v${version}";
      sha256 = "sha256-/gjGTDOXJ0vz/MH2hlistS3X3Euqf8T6TLnD1A2SBYo=";
    };
  });
})
