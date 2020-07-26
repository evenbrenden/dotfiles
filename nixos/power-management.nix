{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.brightnessctl ];

  services = {
    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
    };
    xserver.displayManager.sessionCommands = ''
      xset s off
      xset -dpms
    '';
  };

  services.tlp.enable = false;
  boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ]; # For ThinkPads x TLP
}

