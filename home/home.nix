{ config, pkgs, ... }:

{
  programs = {
    home-manager.enable = true;
    man.enable = false;
    neovim = {
      enable = true;
      extraConfig = pkgs.lib.strings.fileContents ./dotfiles/init.vim;
      plugins = with pkgs.vimPlugins;
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
    [
      autorandr
      brightnessctl
      dunst
      networkmanagerapplet
      libnotify
      lsb-release
      playerctl
      sakura
    ];

  xdg = {
    enable = true;
    configFile = {
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "i3/config".source =
        if config.home.username == "evenbrenden"
        then ./dotfiles/i3config-me
        else ./dotfiles/i3config-u;
      "i3status/config".source = ./dotfiles/i3status;
      "dunst/dunstrc".source = ./dotfiles/dunstrc;
      "autorandr".source = ./dotfiles/autorandr;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
      "nixpkgs/config.nix".source = ./dotfiles/config.nix;
    };
  };
  home.file = {
    ".bashrc".text = with builtins;
      (readFile ./dotfiles/bashrc)
      +
      # Meant to replace channels and NIX_PATH
      ''export NIXPKGS=${readFile ../nixpkgs.url}'';
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    "bin/toggle_keyboard_layout.py".source = ./dotfiles/toggle_keyboard_layout.py;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
  };
}
