{ config, pkgs, ... }:

{
  imports = [ ./home-common.nix ];

  xdg.configFile."i3/config".text = with builtins;
    (readFile ./dotfiles/i3config-common)
    +
    (readFile ./dotfiles/i3config-rm);
}
