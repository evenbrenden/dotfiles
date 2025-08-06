{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
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
    theme = "alabaster";
  };
}
