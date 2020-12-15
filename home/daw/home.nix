{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
  ];

  home.packages = with pkgs; [

    # Plugins
    carla
    espeak-ng
    infamousPlugins
    soundfont-fluid
    surge
    vocproc
    zynaddsubfx

    # Programs
    ardour
    (renoise.override { releasePath = ./rns_324_linux_x86_64.tar.gz; })
  ];

  home.file.".bashrc".text = builtins.readFile ../dotfiles/bashrc;

  # Terrible workaround until I can figure out how to make the desktop item
  # supplied with the Renoise tarball to work when installed via the package
  xdg.dataFile."applications/renoise.desktop".source = ./renoise.desktop;

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}
