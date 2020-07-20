{ pkgs, ... }:

{
  # Until I can figure out how to install acpi-call (for TLP)
  environment.systemPackages = [
    pkgs.power-calibrate
  ];

  programs.xss-lock = {
    enable = true;
    lockerCommand = ''${pkgs.i3lock}/bin/i3lock --color 000000'';
  };

  services = {
    logind = {
      extraConfig = ''
        IdleAction=hybrid-sleep
        IdleActionSec=900
      '';
    };
    tlp.enable = true;
    xserver = {
      displayManager.sessionCommands = ''
        xset -dpms
      '';
    };
  };
}

