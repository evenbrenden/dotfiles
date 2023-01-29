{ pkgs, ... }:

{
  home.packages = with pkgs; [
    arandr
    brightnessctl
    flameshot
    i3quo
    playerctl
    (import ./postrandr.nix { inherit pkgs; })
    sakura
    (import ./toggle-keyboard-layout.nix { inherit pkgs; })
    (import ./toggle-wifi.nix { inherit pkgs; })
    (import ./xrandr-disable-primary-output.nix { inherit pkgs; })
    xrandr-invert-colors
  ];
  xdg.configFile = {
    "i3/config".source = ./config;
    "i3status/config".source = ./statusconfig;
  };
}
