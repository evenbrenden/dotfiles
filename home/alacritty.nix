{ pkgs, ... }:

let
  settings = pkgs.lib.strings.concatStringsSep "\n" [
    ''
      [env]
      TERM = "xterm-256color"

      [font]
      size = 12.0

      [font.bold]
      family = "DejaVu Sans Mono"
      style = "Bold"

      [font.bold_italic]
      family = "DejaVu Sans Mono"
      style = "Bold Oblique"

      [font.italic]
      family = "DejaVu Sans Mono"
      style = "Oblique"

      [font.normal]
      family = "DejaVu Sans Mono"
      style = "Book"
    ''
    (builtins.readFile "${pkgs.alacritty-theme}/share/alacritty-theme/alabaster.toml")
  ];
in {
  home.packages = [ pkgs.alacritty ];
  xdg.configFile."alacritty/alacritty.toml".text = settings;
}
