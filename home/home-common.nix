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
      sakura

      # User programs
      curl
      dbeaver
      git
      i3lock-color
      postman
      rclone
      remmina
      unzip
      zip
    ];

  xdg = {
    enable = true;
    configFile = {
      "autorandr".source = ./dotfiles/autorandr;
      "dunst/dunstrc".source = ./dotfiles/dunstrc;
      "i3status/config".source = ./dotfiles/i3status;
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
    };
  };
  home.file =
    let
      # Workaround for .NET Core SDK installed with Nix (https://wiki.archlinux.org/index.php/.NET_Core)
      dotnet_root = "export DOTNET_ROOT=${pkgs.dotnet-sdk_3}\n";
      dotnet_tools = "PATH=$PATH:${config.home.homeDirectory}/.dotnet/tools\n";
    in
    {
      ".bashrc".text =
        (builtins.readFile ./dotfiles/bashrc)
        + dotnet_root + dotnet_tools;
      ".profile".text = dotnet_root + dotnet_tools;
      ".gitignore".source = ./dotfiles/gitignore;
      ".gitconfig".source = ./dotfiles/gitconfig;
      "bin/i3status.sh".source = ./dotfiles/i3status.sh;
      "bin/toggle_keyboard_layout.py".source = ./dotfiles/toggle_keyboard_layout.py;
    };
}
