{ config, pkgs, ... }:

let
  vim-fsharp = pkgs.vimUtils.buildVimPlugin {
    name = "vim-fsharp";
    src = pkgs.fetchFromGitHub {
      owner = "wsdjeg";
      repo = "vim-fsharp";
      rev = "a4255ba4866fa5aba91fec342f98964cffbbc542";
      sha256 = "0vlr90x4rp30a98k0g1g0fmwmp0slblp74fr8zaclyvbc8kwzimc";
    };
  };
  vim-pico8-syntax = pkgs.vimUtils.buildVimPlugin {
    name = "vim-pico-syntax";
    src = pkgs.fetchFromGitHub {
      owner = "justinj";
      repo = "vim-pico8-syntax";
      rev = "dbdd92fad0533eeaeaea844815d4de11e9507ce7";
      sha256 = "0say0bb74rdbabgsf7rrbm8x841pmgh80fwr6kn94fgphr3vhm0s";
    };
  };
in
{
  programs = {
    home-manager.enable = true;
    man.enable = false;
    vim = with pkgs.vimPlugins; {
      enable = true;
      extraConfig = pkgs.lib.strings.fileContents ./dotfiles/vimrc;
      plugins = [
        vim-airline
        vim-gitgutter
        tcomment_vim
        vim-nix
        vim-fsharp
        vim-pico8-syntax
      ];
    };
  };
  xdg = {
    enable = true;
    configFile = {
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "i3/config".source = ./dotfiles/i3config;
      "i3status/config".source = ./dotfiles/i3status;
      "dunst/dunstrc".source = ./dotfiles/dunstrc;
    };
  };
  home.file = {
    ".bashrc".source = ./dotfiles/bashrc;
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    ".driverc".source = ./dotfiles/driverc;
    "adjust_brightness.py".source = ./dotfiles/adjust_brightness.py;
    "notifications.py".source = ./dotfiles/notifications.py;
    "toggle_keyboard_layout.py".source = ./dotfiles/toggle_keyboard_layout.py;
    "toggle_keyboard_backlight.py".source = ./dotfiles/toggle_keyboard_backlight.py;
    "i3status.sh".source = ./dotfiles/i3status.sh;
  };
}
