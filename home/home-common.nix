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
      # For dotfiles
      dotnet-sdk_3
      lsb-release
      sakura

      # User programs
      curl
      dbeaver
      git
      postman
      rclone
      remmina
      unzip
      zip
    ];

  xdg = {
    enable = true;
    configFile = {
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "i3status/config".source = ./dotfiles/i3status;
      "dunst/dunstrc".source = ./dotfiles/dunstrc;
      "autorandr".source = ./dotfiles/autorandr;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
      "nixpkgs/config.nix".source = ./dotfiles/config.nix;
    };
  };
  home.file = rec {
    ".bashrc".text =
      (builtins.readFile ./dotfiles/bashrc)
      +
      # Workaround for .NET Core SDK installed with Nix (https://wiki.archlinux.org/index.php/.NET_Core)
      "export DOTNET_ROOT=${pkgs.dotnet-sdk_3}; PATH=$PATH:$HOME/.dotnet/tools";
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    "bin/toggle_keyboard_layout.py".source = ./dotfiles/toggle_keyboard_layout.py;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
  };
}
