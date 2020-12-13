{ config, pkgs, ... }:

{
  programs.xss-lock = {
    enable = true;
    extraOptions = [ "--transfer-sleep-lock" ];
    lockerCommand = ''
      env \
      XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
      XSECURELOCK_KEY_XF86Display_COMMAND='${pkgs.autorandr}/bin/autorandr --change' \
      ${pkgs.xsecurelock}/bin/xsecurelock
    '';
  };

  services = {
    logind.lidSwitch = "ignore";
    xserver = {
      displayManager.sessionCommands = ''
        xset s off
        xset -dpms
      '';
      # Temporarily disable with: systemctl --user stop xautolock.service
      xautolock = {
        enable = true;
        extraOptions = [ "-secure" ];
        locker = ''${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID'';
        time = 15; # Minutes
      };
    };
  };

  services.tlp.enable = false;
  # boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ]; # For ThinkPads x TLP
}
