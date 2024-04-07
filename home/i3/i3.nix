{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    autorandr
    brightnessctl
    flameshot
    i3quo
    playerctl
    (import ./set-dpi.nix { inherit pkgs; })
    tesseract
    xcwd
    xrandr-invert-colors
  ];
  xdg.configFile = {
    "i3/config".source = ./config;
    "i3status/config".source = ./statusconfig;
  };
}
