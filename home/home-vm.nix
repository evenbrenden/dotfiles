{ config, pkgs, ... }:

{
  imports = [ ./home-common.nix ];

  home.packages = with pkgs;
    [
      curl
      dbeaver
      git
      postman
      rclone
      remmina
      unzip
      zip
    ];

  # For non-NixOS systems
  home.file.".profile".source = ./dotfiles/profile;

  xdg.configFile."i3/config".text = with builtins;
    (readFile ./dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config-vm);
}
