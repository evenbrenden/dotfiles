{ pkgs }:

pkgs.writeShellApplication {
  name = "fmtall";
  runtimeInputs = [ pkgs.haskellPackages.fourmolu ];
  text = ''
    find . -name '*.hs' -exec sh -c 'fourmolu -iq "$1"' shell {} \;
  '';
}
