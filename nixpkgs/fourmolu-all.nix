{ pkgs }:

pkgs.writeShellApplication {
  name = "fourmolu-all";
  runtimeInputs = [ pkgs.haskellPackages.fourmolu ];
  text = ''
    find . -name '*.hs' -exec sh -c 'fourmolu -iq "$1"' shell {} \;
  '';
}
