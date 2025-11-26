{ pkgs, ... }:

with pkgs.lib;

{
  # systemctl --user stop xss-lock.service
  services.screen-locker = {
    enable = true;
    inactiveInterval = 15;
    # https://github.com/google/xsecurelock/issues/186
    # https://github.com/google/xsecurelock/issues/182
    lockCmd = "${getExe pkgs.xsecurelock}";
    lockCmdEnv = [
      "XSECURELOCK_DISCARD_FIRST_KEYPRESS=0"
      "XSECURELOCK_KEY_F7_COMMAND=${getExe pkgs.refresh-display}"
      "XSECURELOCK_KEY_XF86Display_COMMAND=${getExe pkgs.refresh-display}"
    ];
    xss-lock.extraOptions = [ "--transfer-sleep-lock" ];
  };

  systemd.user.services.disable-xset-s-and-dpms = {
    Unit = {
      Description = "Disable DPMS";
      After = [ "xss-lock.service" ];
    };
    Install.WantedBy = [ "xss-lock.service" ];
    Service = {
      Type = "oneshot";
      ExecStart = "${getExe pkgs.bash} -c '${getExe pkgs.xorg.xset} -dpms'";
    };
  };
}
