(self: super:
  {
    jotta-cli = super.jotta-cli.overrideAttrs (_: rec {
      pname = "jotta-cli";
      version = "0.9.39536";

      src =
        let
          arch = "amd64";
        in
        super.fetchzip {
          url = "https://repo.jotta.us/archives/linux/${arch}/jotta-cli-${version}_linux_${arch}.tar.gz";
          sha256 = "0svp5y867gza4ajshi8qndcvn29xrzf75gks3c8hlrdp53lmr6r5";
          stripRoot = false;
        };
    });
  }
)
