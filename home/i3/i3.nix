{ pkgs, ... }:

{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = null;
      extraConfig = builtins.readFile ./config;
    };
    scriptPath = ".hm-xsession"; # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
  };

  xdg.configFile."i3status/config".source = ./statusconfig;

  home.packages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "alacritty-xcwd";
      runtimeInputs = [ alacritty xcwd ];
      text = ''
        alacritty --working-directory "$(xcwd)"
      '';
    })
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
}
