{ pkgs }:

pkgs.writeShellApplication {
  name = "nixfmt";
  runtimeInputs = [ pkgs.nixfmt-classic ];
  text = ''
    nixfmt --width=120 "$@"
  '';
}
