{ pkgs }:

{
  services.refresh-wallpaper = {
    Unit.Description = "Refresh wallpaper";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.lib.getExe pkgs.refresh-wallpaper}";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
  timers.refresh-wallpaper = {
    Unit.Description = "Wallpaper timer";
    Timer = {
      OnCalendar = [ "12:00" "00:00" ];
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
