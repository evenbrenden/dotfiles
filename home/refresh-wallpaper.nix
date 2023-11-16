{ pkgs }:
let
  awesome_bg_0 = builtins.fetchurl {
    url = "https://trisquel.info/files/awesome_bg_0.png";
    sha256 = "04jszqp8g63s7dm6k07j8plq4dx5c3cv6rp3xzx5ihxhl433jc9k";
  };
in pkgs.writeShellApplication {
  name = "refresh-wallpaper";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    hsetroot -alpha 64 -tile ${awesome_bg_0}
  '';
}
