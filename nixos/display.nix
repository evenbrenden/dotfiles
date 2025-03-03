{ ... }:

{
  services = {

    displayManager.defaultSession = "none+i3";
    xserver = {
      # Combat screen tearing
      deviceSection = ''
        Option "TearFree" "true"
      '';

      enable = true;

      # This can be moved to home-manager
      windowManager.i3.enable = true;
    };
  };
}
