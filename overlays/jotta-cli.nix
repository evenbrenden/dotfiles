(self: super:
  {
    jotta-cli = super.jotta-cli.overrideAttrs (_: rec {
      pname = "jotta-cli";
      version = "0.9.39535";

      src =
        let
          arch = "amd64";
        in
        super.fetchzip {
          url = "https://repo.jotta.us/archives-unstable/linux/${arch}/jotta-cli-${version}_linux_${arch}.tar.gz";
          sha256 = "0mw1xb2mpnrmp4dr874ybim47pn05h153qj1lnwacmm1zfjykgd6";
          stripRoot = false;
        };
    });
  }
)
