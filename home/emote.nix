{ pkgs, ... }:

{
  systemd.user.services.emote = {
    Unit = {
      Description = "Emoji Picker for Linux written in GTK3";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.lib.getExe pkgs.emote}";
      Restart = "on-abort";
    };
  };
}
