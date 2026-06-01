{ pkgs }:

pkgs.writeShellApplication {
  name = "nixfmt-all";
  runtimeInputs = [ pkgs.nixfmt ];
  text = ''
    find . -name '*.nix' -exec sh -c 'nixfmt "$1"' shell {} \;
  '';
}
