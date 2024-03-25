{ pkgs }:

let
  landscape-drawing = pkgs.fetchurl {
    url = "https://i.etsystatic.com/27770216/r/il/5eb29a/3176801816/il_fullxfull.3176801816_r95l.jpg";
    sha256 = "sha256-WPpbBW7NwxBOKg93ofqOfEOprD1SvxChKZvzkcTqHC8=";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -fill ${landscape-drawing}
  '';
}
