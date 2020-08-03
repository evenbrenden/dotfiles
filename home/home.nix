{ config, pkgs, ... }:

{
  programs = {
    home-manager.enable = true;
    man.enable = false;
    neovim = with pkgs.vimPlugins; {
      enable = true;
      extraConfig = pkgs.lib.strings.fileContents ./dotfiles/init.vim;
      plugins =
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
        in
        [
          vim-airline
          vim-fsharp
          vim-gitgutter
          vim-markdown
          vim-nix
          vim-pico8-syntax
          tcomment_vim
        ];
    };
  };
  home.packages = with pkgs;
    let
      dunst_pinned = pkgs.dunst.overrideAttrs (oldAttrs: rec {
        version = "1.5.0";
        src = pkgs.fetchFromGitHub {
          owner = "dunst-project";
          repo = "dunst";
          rev = "52d67616f1dcd9d4201de3f8096cbc2c09dbf1dd";
          sha256 = "0irwkqcgwkqaylcpvqgh25gn2ysbdm2kydipxfzcq1ddj9ns6f9c";
        };
      });
    in
    [
      autorandr
      brightnessctl
      dunst_pinned
      networkmanagerapplet
      libnotify
      playerctl
      sakura
    ];

  xdg = {
    enable = true;
    configFile = {
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "i3/config".source = ./dotfiles/i3config;
      "i3status/config".source = ./dotfiles/i3status;
      "dunst/dunstrc".source = ./dotfiles/dunstrc;
      "autorandr".source = ./dotfiles/autorandr;
    };
  };
  home.file = {
    ".bashrc".source = ./dotfiles/bashrc;
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    "bin/adjust_brightness.py".source = ./dotfiles/adjust_brightness.py;
    "bin/toggle_keyboard_layout.py".source = ./dotfiles/toggle_keyboard_layout.py;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
  };
}

