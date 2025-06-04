{ pkgs, ... }:

with pkgs.lib;

{
  services = {
    screen-locker = {
      enable = true;
      lockCmd = let
        # https://github.com/google/xsecurelock/issues/186
        # https://github.com/google/xsecurelock/issues/182
        xsecurelock-command = pkgs.writeShellApplication {
          name = "xsecurelock-command";
          runtimeInputs = [ pkgs.refresh-display pkgs.xsecurelock ];
          text = ''
            XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
            XSECURELOCK_KEY_F7_COMMAND=refresh-display \
            XSECURELOCK_KEY_XF86Display_COMMAND=refresh-display \
            xsecurelock
          '';
        };
      in "${getExe xsecurelock-command}";
      xss-lock.extraOptions = [ "--transfer-sleep-lock" ];
    };
    xidlehook = {
      enable = true;
      not-when-fullscreen = true;
      timers = [{
        command = "${getExe' pkgs.systemd "loginctl"} lock-session \${XDG_SESSION_ID}";
        delay = 15 * 60;
      }];
    };
  };

  systemd.user.services.disable-xset-s-and-dpms = {
    Unit = {
      Description = "Disable X Screen Saver and DPMS";
      After = [ "xss-lock.service" ];
    };
    Install.WantedBy = [ "xss-lock.service" ];
    Service = {
      Type = "oneshot";
      ExecStart = "${getExe pkgs.bash} -c '${getExe pkgs.xorg.xset} s off -dpms'";
    };
  };
}
