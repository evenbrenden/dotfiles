{ ... }:

{
  services = {
    displayManager.defaultSession = "none+i3";
    xserver = {
      deviceSection = ''
        Option "TearFree" "true"
      '';
      enable = true;

      # This can be moved to home-manager
      # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
      windowManager.i3.enable = true;
    };
  };
}
