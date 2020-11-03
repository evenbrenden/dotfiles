{ config, pkgs, ... }:

{
  imports = [ ../home-common.nix ];

  nixpkgs.overlays = [
    (import ../../overlays/jetbrains.rider.nix)
    (import ../../overlays/jotta-cli.nix)
  ];

  home.packages = with pkgs;
    [
      # For dotfiles
      autorandr
      brightnessctl
      dunst
      networkmanagerapplet
      libnotify
      playerctl

      # User programs
      abcde
      arandr
      cabal-install
      chromium
      dos2unix
      firefox
      flameshot
      fzf
      gimp
      gparted
      graphviz
      irssi
      jetbrains.rider
      jotta-cli
      jq
      vlc
      nomacs
      pavucontrol
      python3
      python37Packages.virtualenv
      (callPackage (import ../../pkgs/rclone-sync) {})
      shellcheck
      slack
      snes9x-gtk
      spotify
      teams
      transmission-gtk
      udiskie
      veracrypt
    ];
    programs.vscode = {
      enable = true;
      extensions = [ (pkgs.callPackage (import ../../pkgs/ms-vsliveshare-vsliveshare) {}) ];
      userSettings = {
        "editor.occurrencesHighlight" = true;
        "editor.renderLineHighlight" = "none";
        "editor.copyWithSyntaxHighlighting" = false;
        "editor.highlightActiveIndentGuide" = false;
        "workbench.editor.highlightModifiedTabs" = true;
        "editor.renderIndentGuides" = false;
        "editor.cursorBlinking" = "solid";
        "editor.cursorStyle" = "block";
        "editor.minimap.enabled" = false;
        "editor.matchBrackets" = "never";
        "editor.links" = false;
        "workbench.editor.enablePreview" = false;
        "FSharp.useSdkScripts" = true;
      };
    };

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}
