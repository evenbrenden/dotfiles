{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty-xcwd
    autorandr
    brightnessctl
    dmenu
    flameshot
    i3status
    i3quo
    playerctl
    refresh-display
    set-dpi
    systemd
    tesseract
    toggle-keyboard-layout
    xrandr-invert-colors
    xtrlock-pam
  ];

  xdg.configFile."i3status/config".source = ./dotfiles/i3statusconfig;

  xsession.windowManager.i3 = {
    config = null;
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/i3config;
  };
}
