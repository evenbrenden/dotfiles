(self: super:
  {
    jotta-cli = super.jotta-cli.overrideAttrs (_: rec {
      pname = "jotta-cli";
      version = "0.11.44593";

      src =
        let
          arch = "amd64";
        in
        super.fetchzip {
          url = "https://repo.jotta.us/archives/linux/${arch}/jotta-cli-${version}_linux_${arch}.tar.gz";
          sha256 = "1f06zmcpvm0f3phwc43ai6v4ykhkrd4f3br2j89nx9bfmj6ss2ic";
          stripRoot = false;
        };
      postFixup = ''
        patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) $out/bin/jotta-cli
        patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) $out/bin/jottad
        $out/bin/jotta-cli completion bash > $out/share/bash-completion/completions/jotta-cli.bash
      '';
    });
  }
)
