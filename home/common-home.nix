{ config, pkgs, ... }:

{
  # Programs
  nixpkgs.overlays = [
    (import ./jotta-cli.nix)
  ];
  programs = {
    home-manager.enable = true;
    man.enable = false;
    neovim = {
      enable = true;
      extraConfig = pkgs.lib.strings.fileContents ./dotfiles/init.vim;
      plugins = with pkgs.vimPlugins;
        let
          sfz-vim = pkgs.vimUtils.buildVimPlugin {
            name = "sfz-vim";
            src = pkgs.fetchFromGitHub {
              owner = "sfztools";
              repo = "sfz.vim";
              rev = "4ec4ad05beacd1ec69dc37dc8137f92d4c673fef";
              sha256 = "0brk6847n8wd8zb57wp7wjxyc7i3r0q29riv8ppy39j5lpdsbbss";
            };
          };
          vim-fsharp = pkgs.vimUtils.buildVimPlugin {
            name = "vim-fsharp";
            src = pkgs.fetchFromGitHub {
              owner = "wsdjeg";
              repo = "vim-fsharp";
              rev = "a4255ba4866fa5aba91fec342f98964cffbbc542";
              sha256 = "0vlr90x4rp30a98k0g1g0fmwmp0slblp74fr8zaclyvbc8kwzimc";
            };
          };
          vim-markdown = pkgs.vimUtils.buildVimPluginFrom2Nix {
            name = "vim-markdown";
            src = pkgs.fetchFromGitHub {
              owner = "evenbrenden";
              repo = "vim-markdown";
              rev = "988e7d540f48181fd11f558b82f1163f1ab16fc2";
              sha256 = "0n69ykyd4a94hvqkhg3qrqix2bk4yi21p4s43kph9yh6zjj32jk3";
            };
          };
        in
        [
          fzf-vim
          tcomment_vim
          sfz-vim
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
      audacity
      cabal-install
      chromium
      curl
      dos2unix
      firefox
      fff
      flac
      flameshot
      fzf
      gimp
      git
      gparted
      graphviz
      irssi
      jotta-cli
      jq
      libreoffice
      marker
      nomacs
      p7zip
      pandoc
      pavucontrol
      python3
      python37Packages.virtualenv
      rclone
      shellcheck
      slack
      smartmontools
      snes9x-gtk
      spotify
      standardnotes
      teams
      transmission-gtk
      veracrypt
      vlc
      xclip
    ];

  # Services
  services = {
    dunst.enable = true;
    network-manager-applet.enable = true;
  };
  systemd.user.startServices = true;

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
