{ pkgs }:
let
  # https://unsplash.com/photos/green-trees-9HDfRHhCxME
  green-trees = builtins.fetchurl {
    url = "https://images.unsplash.com/photo-1492741428243-892c600f7dbc";
    sha256 = "0zzrk7m5a9gjdgm35icnddli8g7i6cnwcvpwnv54f9wfpnviins9";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -alpha 128 -cover ${green-trees}
  '';
}
