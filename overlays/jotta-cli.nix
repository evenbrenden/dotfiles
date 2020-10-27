(self: super:
  {
    jotta-cli = super.jotta-cli.overrideAttrs (_: rec {
      pname = "jotta-cli";
      version = "0.7.33634";

      src =
        let
          arch = "amd64";
        in
        super.fetchzip {
          url = "https://repo.jotta.us/archives/linux/${arch}/jotta-cli-${version}_linux_${arch}.tar.gz";
          sha256 = "0apbdk4fvmn52w9qyh6hvpk3k0sa810jvvndpsbysnlmi7gv5w62";
          stripRoot = false;
        };
    });
  }
)
