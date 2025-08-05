{ config, pkgs, ... }:

let
  settings = ''
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

    ${builtins.readFile "${pkgs.alacritty-theme}/share/alacritty-theme/alabaster.toml"}
  '';
in {
  # https://github.com/NixOS/nixpkgs/issues/122671
  home.packages = if config.targets.genericLinux.enable then [ ] else [ pkgs.alacritty ];
  xdg.configFile."alacritty/alacritty.toml".text = settings;
}
