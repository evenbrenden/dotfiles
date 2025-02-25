{ pkgs, ... }:

{
  services = {
    screen-locker = {
      enable = true;
      lockCmd = ''
        env \
        XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
        XSECURELOCK_KEY_XF86Display_COMMAND='${pkgs.autorandr}/bin/autorandr --force --change clone-largest' \
        XSECURELOCK_KEY_F7_COMMAND='${pkgs.autorandr}/bin/autorandr --force --change clone-largest' \
        ${pkgs.xsecurelock}/bin/xsecurelock
      '';
      xss-lock.extraOptions = [ "--transfer-sleep-lock" ];
    };
    # Temporarily disable with: systemctl --user stop xidlehook.service
    xidlehook = {
      enable = true;
      timers = [{
        command = "${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
        delay = 15 * 60;
      }];
      not-when-fullscreen = true;
    };
  };
}
