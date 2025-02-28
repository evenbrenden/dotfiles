{ pkgs, ... }:

{
  # This can be moved to home-manager
  systemd.services = {
    auto-mute-mode = {
      description = "Set Auto-Mute Mode";
      script = ''
        amixer -c 0 set 'Auto-Mute Mode' 'Disabled'
      '';
      path = [ pkgs.alsa-utils ];
      after = [ "multi-user.target" "sound.target" "graphical.target" ];
      wantedBy = [ "sound.target" ];
    };
  };
}
