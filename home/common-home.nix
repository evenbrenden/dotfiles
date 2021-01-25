{ config, pkgs, ... }:

{
  # Programs
  nixpkgs.overlays = [
    (import ../overlays/jotta-cli.nix) # 0.9.38023
  ];
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
      dunst # For dunstctl
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
      fff
      fzf
      gimp
      git
      gparted
      graphviz
      irssi
      jotta-cli
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
      (callPackage (import ../pkgs/standardnotes) {}) # https://github.com/NixOS/nixpkgs/pull/106392#issuecomment-766825478
      teams
      transmission-gtk
      unzip
      veracrypt
      xclip
      zip
    ];

  # Services
  services = {
    dunst.enable = true;
    network-manager-applet.enable = true;
  };

  # Actual dotfiles (not managed home-manager style)
  xdg = {
    enable = true;
    configFile = {
      "autorandr".source = ./dotfiles/autorandr;
      "dunst/dunstrc".source = ./dotfiles/dunstrc;
      "i3/config".source = ./dotfiles/i3config;
      "i3status/config".source = ./dotfiles/i3status;
      "sakura/sakura.conf".source = ./dotfiles/sakura.conf;
      "snes9x/snes9x.conf".source = ./dotfiles/snes9x.conf;
    };
  };
  home.file = {
    ".bashrc".text = builtins.readFile ./dotfiles/bashrc; # .text => file is being prepended/appended to elsewhere
    ".gitignore".source = ./dotfiles/gitignore;
    ".gitconfig".source = ./dotfiles/gitconfig;
    "bin/i3status.sh".source = ./dotfiles/i3status.sh;
    "bin/toggle_keyboard_layout.py".source = ./dotfiles/toggle_keyboard_layout.py;
    "bin/toggle_wifi.py".source = ./dotfiles/toggle_wifi.py;
  };
}
