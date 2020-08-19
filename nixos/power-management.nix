{ config, pkgs, ... }:

{
  programs.xss-lock = {
    enable = true;
    lockerCommand = ''${pkgs.i3lock-color}/bin/i3lock-color --color 000000 --pass-screen-keys'';
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
      xautolock =
        let
          lock-time = 60; # minutes
          lock-notify = 60; # seconds
        in
          {
            enable = true;
            enableNotifier = true;
            extraOptions = [ "-secure" ];
            locker = ''${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID'';
            notifier = ''${pkgs.libnotify}/bin/notify-send "Lock in ${toString lock-notify} seconds"'';
            notify = lock-notify;
            time = lock-time;
          };
    };
  };

  services.tlp.enable = false;
  # boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ]; # For ThinkPads x TLP
}
