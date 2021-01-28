(self: super:
  {
    jotta-cli = super.jotta-cli.overrideAttrs (_: rec {
      pname = "jotta-cli";
      version = "0.9.39282";

      src =
        let
          arch = "amd64";
        in
        super.fetchzip {
          url = "https://repo.jotta.us/archives-unstable/linux/${arch}/jotta-cli-${version}_linux_${arch}.tar.gz";
          sha256 = "04v0ircyr5grhpkzljm2v08q455w4ql65a2927jkalmphlyn9jas";
          stripRoot = false;
        };
    });
  }
)
