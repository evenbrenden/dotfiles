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
    (renoise.override {
        releasePath = builtins.fetchTarball {
          url = "file://${builtins.toString ./.}/rns_324_linux_x86_64.tar.gz";
          sha256 = "0jwk9z62kk5dk95cbqasjrbag0qwvl2lix5k0pd98dmx05lxvbi5";
        };
      }
    )
  ];

  home.file.".bashrc".text = builtins.readFile ../dotfiles/bashrc;

  # Terrible workaround until I can figure out how to make the desktop item
  # supplied with the Renoise tarball to work when installed via the package
  xdg.dataFile."applications/renoise.desktop".source = ./renoise.desktop;
}
