# https://github.com/NixOS/nixpkgs/pull/130884
(self: super:
  {
    sof-firmware = super.sof-firmware.overrideAttrs (_: rec {

      version = "1.8";

      src = super.fetchFromGitHub {
        owner = "thesofproject";
        repo = "sof-bin";
        rev = "v${version}";
        sha256 = "sha256-NPbzDXZoZVWriV3klemX59ACnAlb357A5V/GbmzshyA=";
      };

      buildInputs = [
        super.pkgs.alsaLib
        super.pkgs.autoPatchelfHook
        super.pkgs.rsync
      ];

      # Doesn't seem to make a difference for the firmware binaries. Just unnecessary?
      # If not, we need a separate fixupPhase for patching and stripping the tools.
      dontFixup = false;

      # Tools would also need to be added to systemPackages (if firmware is installed).
      installPhase = ''
        mkdir -p $out/lib/firmware/intel/
        mkdir -p $out/bin/
        export FW_DEST=$out/lib/firmware/intel
        export TOOLS_DEST=$out/bin
        ./install.sh v1.8.x/v1.8
        rm -rf $out/bin # No thanks for now
      '';
    });
  }
)
