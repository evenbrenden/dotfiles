{ config, pkgs, ... }:

{
  programs.xss-lock = {
    enable = true;
    extraOptions = [ "--transfer-sleep-lock" ];
    # https://github.com/google/xsecurelock/issues/97 => XSECURELOCK_NO_COMPOSITE=1
    # "This switches to a more traditional way of locking, but may allow desktop
    # notifications to be visible on top of the screen lock. Not recommended."
    lockerCommand = ''
      env \
      XSECURELOCK_NO_COMPOSITE=1 \
      XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
      XSECURELOCK_KEY_XF86Display_COMMAND='${pkgs.autorandr}/bin/autorandr --change' \
      ${pkgs.xsecurelock}/bin/xsecurelock
    '';
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
