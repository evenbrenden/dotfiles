{ pkgs, ... }:

with pkgs.lib;

{
  services = {
    # https://github.com/nix-community/home-manager/pull/6534
    screen-locker = {
      enable = true;
      lockCmd = let
        # https://github.com/google/xsecurelock/issues/186
        # https://github.com/google/xsecurelock/issues/182
        xsecurelock-command = pkgs.writeShellApplication {
          name = "xsecurelock-command";
          runtimeInputs = [ pkgs.autorandr pkgs.xsecurelock ];
          text = let autorandr-command = "autorandr --force --change clone-largest";
          in ''
            XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
            XSECURELOCK_KEY_XF86Display_COMMAND='${autorandr-command}' \
            XSECURELOCK_KEY_F7_COMMAND='${autorandr-command}' \
            xsecurelock
          '';
        };
      in "${getExe xsecurelock-command}";
      xss-lock.extraOptions = [ "--transfer-sleep-lock" ];
    };
    # https://github.com/nix-community/home-manager/pull/6533
    # Disable with: systemctl --user stop xidlehook.service
    xidlehook = {
      enable = true;
      timers = [{
        command = "${getExe' pkgs.systemd "loginctl"} lock-session \${XDG_SESSION_ID}";
        delay = 15 * 60;
      }];
      not-when-fullscreen = true;
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
