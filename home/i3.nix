{ pkgs, ... }:

{
  home.packages = with pkgs; [
    autorandr
    brightnessctl
    clipmenu
    dmenu
    flameshot
    i3status
    i3quo
    playerctl
    pulseaudio
    refresh-display
    set-dpi
    systemd
    tesseract
    toggle-keyboard-layout
    xcwd
    xrandr-invert-colors
  ];

  xdg.configFile."i3status/config".source = ./dotfiles/i3statusconfig;

  xsession.windowManager.i3 = {
    config = null;
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/i3config;
  };
}
