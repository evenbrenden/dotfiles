(self: super:
  {
    jotta-cli = super.jotta-cli.overrideAttrs (_: rec {
      pname = "jotta-cli";
      version = "0.7.35160";

      src =
        let
          arch = "amd64";
        in
        super.fetchzip {
          url = "https://repo.jotta.us/archives/linux/${arch}/jotta-cli-${version}_linux_${arch}.tar.gz";
          sha256 = "00fzycy199l9y738cj71s88qz96ppczb5sqsk3x9w4jj4m6ks239";
          stripRoot = false;
        };
    });
  }
)
