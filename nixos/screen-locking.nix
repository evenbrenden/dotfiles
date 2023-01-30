{ pkgs, ... }:

# This can be moved to home-manager
{
  programs.xss-lock = {
    enable = true;
    extraOptions = [ "--transfer-sleep-lock" ];
    lockerCommand = ''
      env \
      XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
      XSECURELOCK_KEY_XF86Display_COMMAND='${pkgs.autorandr}/bin/autorandr --force --change common' \
      ${pkgs.xsecurelock}/bin/xsecurelock
    '';
  };

  # Temporarily disable with: systemctl --user stop xidlehook.service
  systemd.user.services.xidlehook = let
    timeout-secs = 15 * 60;
    lock-command = "${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
    canceller = "";
    options = "--not-when-fullscreen";
  in {
    description = "xidlehook service";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.xidlehook}/bin/xidlehook ${options} --timer ${
          toString timeout-secs
        } "${lock-command}" "${canceller}"'';
      Restart = "always";
    };
  };

  services.xserver.displayManager.sessionCommands = ''
    xset s off
    xset -dpms
  '';
}
