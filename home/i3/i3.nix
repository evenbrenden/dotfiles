{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (import ./alacritty-xcwd.nix { inherit pkgs; })
    autorandr
    brightnessctl
    dmenu
    flameshot
    i3status
    i3quo
    playerctl
    (import ./set-dpi.nix { inherit pkgs; })
    systemd
    tesseract
    (import ./toggle-keyboard-layout.nix { inherit pkgs; })
    xrandr-invert-colors
  ];

  xdg.configFile."i3status/config".source = ./statusconfig;

  xsession.windowManager.i3 = {
    config = null;
    enable = true;
    extraConfig = builtins.readFile ./config;
  };
}
