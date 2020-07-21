{ config, pkgs, ... }:

# No battery actions or notifications (i3status is sufficient)
# No lid actions (screen shuts off on lid close anyway)
# No display power management (manual brightness control)
# Lock on inactivity (using i3lock directly) (for security)
# Make sure screen is locked on sleep (using xss-lock)
# Sleep and shutdown on command only (using i3 key binds)
# Let TLP do its thing (whatever it is) in the background

let
  lock_time = 15; # minutes
  lock_notify = 30; # seconds
in
  {
    environment.systemPackages = [ pkgs.brightnessctl ];

    programs.xss-lock = {
      enable = true;
      lockerCommand = ''${pkgs.i3lock}/bin/i3lock --color 000000'';
    };

    services = {
      logind = {
        lidSwitch = "ignore";
        lidSwitchDocked = "ignore";
        lidSwitchExternalPower = "ignore";
      };
      xserver = {
        displayManager.sessionCommands = ''
          xset s off
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

