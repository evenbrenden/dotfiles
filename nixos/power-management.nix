{ config, pkgs, ... }:

# No battery actions or notifications (i3status is sufficient)
# No lid actions (screen shuts off on lid close anyway)
# No display power management (manual brightness control)
# Lock and sleep on inactivity (all power buttons ignored)

let
  timeout = 15;
  notify = 30;
in
  {
    environment.systemPackages = [ pkgs.brightnessctl ];
    services = {
      logind = {
        extraConfig = ''
          IdleAction=hybrid-sleep
          IdleActionSec=${toString timeout}min
        '';
        lidSwitch = "ignore";
        lidSwitchDocked = "ignore";
        lidSwitchExternalPower = "ignore";
      };
      xserver = {
        displayManager.sessionCommands = ''
          xset -dpms
        '';
        xautolock = {
          enable = true;
          enableNotifier = true;
          extraOptions = [ "-secure" ];
          locker = ''${pkgs.i3lock}/bin/i3lock --color 000000'';
          notifier = ''${pkgs.libnotify}/bin/notify-send "Lock (and sleep) in ${toString notify}s"'';
          notify = notify;
          time = timeout;
        };
      };
    };
    services.tlp.enable = true;
    boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ]; # For ThinkPads x TLP
  }

