{ pkgs }:

pkgs.writeShellApplication {
  name = "refresh-display";
  runtimeInputs = with pkgs; [ autorandr ];
  text = ''
    autorandr --force --change clone-largest
  '';
}
