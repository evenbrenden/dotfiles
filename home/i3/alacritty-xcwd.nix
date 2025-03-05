{ pkgs }:

pkgs.writeShellApplication {
  name = "alacritty-xcwd";
  runtimeInputs = with pkgs; [ alacritty xcwd ];
  text = ''
    alacritty --working-directory "$(xcwd)"
  '';
}
