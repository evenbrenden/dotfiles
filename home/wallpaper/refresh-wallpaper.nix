{ pkgs }:

pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    current_hour=$(date +%H)
    if [ "$current_hour" -ge 6 ] && [ "$current_hour" -lt 18 ]; then
      hsetroot -add '#FA2AB4' -add '#FDE507' -gradient 30
    else
      hsetroot -add '#069AFC' -add '#D00E91' -gradient 30
    fi
  '';
}
