{ pkgs }:

let
  the-expanding-universe = fetchGit {
    url = "git@codeberg.org:evenbrenden/the-expanding-universe.git";
    rev = "a43dcfaed76fbac5d5757e949b66ffbe372f9cea";
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
