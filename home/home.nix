{ config, ... }:

let
  pinnedNixpkgs = import(import ./pinned_nixpkgs.nix) {};
in
  {
    programs = {
      home-manager.enable = true;
      man.enable = false;
      neovim = {
        enable = true;
        extraConfig = pinnedNixpkgs.lib.strings.fileContents ./dotfiles/init.vim;
        plugins = with pinnedNixpkgs.vimPlugins;
          let
            vim-fsharp = pinnedNixpkgs.vimUtils.buildVimPlugin {
              name = "vim-fsharp";
              src = pinnedNixpkgs.fetchFromGitHub {
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
    home.packages = with pinnedNixpkgs;
      [
        autorandr
        brightnessctl
        dunst
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

