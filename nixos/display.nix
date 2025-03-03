{ pkgs, ... }:

{
  services = {
    displayManager.defaultSession = "home-manager";
    xserver = {
      deviceSection = ''
        Option "TearFree" "true"
      '';
      enable = true;

      # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
      desktopManager.session = [{
        name = "home-manager";
        start = ''
          ${pkgs.runtimeShell} $HOME/.hm-xsession &
          waitPID=$!
        '';
      }];
    };
  };
}
