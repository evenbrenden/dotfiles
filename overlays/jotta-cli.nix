(self: super:
  {
    jotta-cli = super.jotta-cli.overrideAttrs (_: rec {
      pname = "jotta-cli";
      version = "0.9.38023";

      src =
        let
          arch = "amd64";
        in
        super.fetchzip {
          url = "https://repo.jotta.us/archives/linux/${arch}/jotta-cli-${version}_linux_${arch}.tar.gz";
          sha256 = "0whbf7sb4i3g1f6yps3a6l3f0z3dg681ypax4snxw5vchi3h99kc";
          stripRoot = false;
        };
    });
  }
)
