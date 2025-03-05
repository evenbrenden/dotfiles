{ pkgs }:

pkgs.writeShellApplication {
  name = "formatter";
  runtimeInputs = [ pkgs.nixfmt-classic ];
  text = ''
    nixfmt --width=120 "$@"
  '';
}
