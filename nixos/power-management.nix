{ config, pkgs, ... }:

# No battery actions or notifications (i3status is sufficient)
# No lid actions (screen shuts off on lid close anyway)
# No display power management (manual brightness control)
# Lock and sleep on inactivity (all power buttons ignored)

let
  sleep_time = 30; # minutes
  lock_time = 15; # minutes
  lock_notify = 30; # seconds
in
  {
    environment.systemPackages = [ pkgs.brightnessctl ];
    services = {
      logind = {
        # This doesn't seem to work
        extraConfig = ''
          IdleAction=hybrid-sleep
          IdleActionSec=${toString sleep_time}min
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
          notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in ${toString lock_notify} seconds"'';
          notify = lock_notify;
          time = lock_time;
        };
      };
    };
    services.tlp.enable = true;
    boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ]; # For ThinkPads x TLP
  }

