{ pkgs }:

pkgs.writeShellApplication {
  name = "nixfmt-all";
  runtimeInputs = [ pkgs.nixfmt-classic ];
  text = ''
    find . -name '*.nix' -exec sh -c 'nixfmt "$1"' shell {} \;
  '';
}
