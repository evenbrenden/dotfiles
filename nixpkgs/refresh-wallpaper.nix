{ pkgs }:

let
  the-expanding-universe = fetchGit {
    url = "git@codeberg.org:evenbrenden/the-expanding-universe.git";
    rev = "b00e083d2d258087850cb20c543dc14908fe03e9";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ coreutils hsetroot ];
  text = ''
    current_hour=$(date +%H)
    if [ "$current_hour" -ge 0 ] && [ "$current_hour" -lt 12 ]; then
        hsetroot -fill ${the-expanding-universe}/the-expanding-universe-a.png
    else
        hsetroot -fill ${the-expanding-universe}/the-expanding-universe-b.png
    fi
  '';
}
