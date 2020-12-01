{ config, pkgs, ... }:

{
  # Programs
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
          fzf-vim
          tcomment_vim
          vim-airline
          vim-fsharp
          vim-gitgutter
          vim-markdown
          vim-nix
          vim-pico8-syntax
          wmgraphviz-vim
        ];
    };
  };
  home.packages = with pkgs;
    [
      # For dotfiles
      autorandr
      brightnessctl
      dotnet-sdk_3
      dunst
      networkmanagerapplet
      libnotify
      playerctl
      sakura

      # User programs
      abcde
      arandr
      cabal-install
      chromium
      curl
      dos2unix
      firefox
      flameshot
      fzf
      gimp
      git
      gparted
      graphviz
      irssi
      jotta-cli # Waiting for 0.8.36055 (https://github.com/jotta/jotta-cli-issues/issues/111)
      jq
      vlc
      nomacs
      pavucontrol
      python3
      python37Packages.virtualenv
      rclone
      (callPackage (import ../pkgs/rclone-sync) {})
      shellcheck
      slack
      snes9x-gtk
      spotify
      teams
      transmission-gtk
      udiskie
      unzip
      veracrypt
      xclip
      zip
    ];

  # Actual dotfiles
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
      "bin/toggle_wifi.py".source = ./dotfiles/toggle_wifi.py;
    };
}
