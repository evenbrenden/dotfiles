{ pkgs, ... }:

let
  alacritty-theme = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "94e1dc0b9511969a426208fbba24bd7448493785";
    sha256 = "sha256-bPup3AKFGVuUC8CzVhWJPKphHdx0GAc62GxWsUWQ7Xk=";
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${alacritty-theme}/themes/alabaster.toml" ];
      font = {
        size = 12.0;
        normal = {
          family = "DejaVu Sans Mono";
          style = "Book";
        };
        italic = {
          family = "DejaVu Sans Mono";
          style = "Oblique";
        };
        bold = {
          family = "DejaVu Sans Mono";
          style = "Bold";
        };
        bold_italic = {
          family = "DejaVu Sans Mono";
          style = "Bold Oblique";
        };
      };
    };
  };
}
