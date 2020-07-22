{ config, pkgs, ... }:

let
  lock_time = 60; # minutes
  lock_notify = 60; # seconds
in
  {
    environment.systemPackages = [ pkgs.brightnessctl ];

    # nixpkgs issue #67350 (only need this for lock on sleep though)
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
        # can be disabled and reenabled with systemctl
        xautolock = {
          enable = true;
          enableNotifier = true;
          extraOptions = [ "-secure" ];
          locker = ''${pkgs.i3lock}/bin/i3lock --color 000000'';
          notifier = ''${pkgs.libnotify}/bin/notify-send "Lock in ${toString lock_notify} seconds"'';
          notify = lock_notify;
          time = lock_time;
        };
      };
    };

    services.tlp.enable = true;
    boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ]; # For ThinkPads x TLP
  }

