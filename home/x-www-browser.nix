{ pkgs }:

pkgs.writeShellApplication {
  name = "x-www-browser";

  runtimeInputs = [ pkgs.firefox ];

  text = ''
    firefox "$@"
  '';
}
