{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
    flameshot
    i3quo
    playerctl
    sakura
    (import ./toggle-keyboard-layout.nix { inherit pkgs; })
    (import ./toggle-wifi.nix { inherit pkgs; })
    (import ./xrandr-disable-primary.nix { inherit pkgs; })
    xrandr-invert-colors
  ];
  xdg.configFile = {
    "i3/config".source = ./config;
    "i3status/config".source = ./statusconfig;
  };
}
