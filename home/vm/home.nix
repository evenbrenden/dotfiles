{ config, pkgs, ... }:

{
  imports = [
    ../common-home.nix
    ../dotnet.nix
  ];

  # This is only so that dmenu is able to list programs that are installed with Nix
  programs.bash.enable = true; # So that session variables are sourced in ~/.profile
  targets.genericLinux.enable = true; # So that Nix profile is added to XDG_DATA_DIRS

  # Note that on some distros you might want to uninstall dunst (or else you might
  # get a warning on every home-manager switch)

  home.file.".bashrc".text = builtins.readFile ../dotfiles/bashrc;

  xdg.configFile."i3/config".text = with builtins;
    (readFile ../dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config);
}
