{ pkgs, ... }:

{
  systemd.services = {
    auto-mute-mode = {
      description = "Set Auto-Mute Mode";
      script = ''
        amixer -c 0 set 'Auto-Mute Mode' 'Disabled'
      '';
      path = [ pkgs.alsaUtils ];
      after = [ "multi-user.target" "sound.target" "graphical.target" ];
      wantedBy = [ "sound.target" ];
    };
  };
}
