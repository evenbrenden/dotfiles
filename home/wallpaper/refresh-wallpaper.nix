{ pkgs }:

pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -solid '#AA98A9' # Rose quartz
  '';
}
