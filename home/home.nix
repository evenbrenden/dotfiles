{ config, pkgs, ... }:

{
  services.screen-locker =
    let
      lock-time = 60; # minutes
      lock-notify = 60; # seconds
    in
      {
        enable = true;
        inactiveInterval = lock-time;
        xautolockExtraOptions = [
          "-secure"
          "-notify"
          "${toString lock-notify}"
          "-notifier"
          "'${pkgs.libnotify}/bin/notify-send \"Lock in ${toString lock-notify} seconds\"'"
        ];
        lockCmd = ''${pkgs.i3lock}/bin/i3lock --color 000000'';
      };

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
    "bin/notifications.py".source = ./dotfiles/notifications.py;
    "bin/toggle_keyboard_layout.py".source = ./dotfiles/toggle_keyboard_layout.py;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
  };
}

