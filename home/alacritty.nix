let
  blue-mood = builtins.fetchGit {
    url = "git@codeberg.org:evenbrenden/blue-mood-alacritty.git";
    rev = "ea964a846560fe44da85ab4c4c50da63588c08fb";
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${blue-mood}/blue-mood.yml" ];
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
