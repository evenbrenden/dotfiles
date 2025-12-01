{ pkgs, ... }:

{
  systemd = {
    services = let sleep-targets = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    in {
      # This addresses the "(...) slight "pop" in headphones when content volume transitions to/from 0."
      # It attenuates the pops to the point that they are virtually inaudible
      # Note that the pops are "Also present on mainline and in Windows."
      headphone-pops-fix = {
        description = "Headphone pops fix";
        script = ''
          # https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3154512
          hda-verb /dev/snd/hwC0D0 0x1d SET_PIN_WIDGET_CONTROL 0x0
          # This node behaves the same way (and this is the default value)
          hda-verb /dev/snd/hwC0D0 0x1a SET_PIN_WIDGET_CONTROL 0x0
        '';
        path = [ pkgs.alsa-tools ];
        after = [ "multi-user.target" "sound.target" "graphical.target" ] ++ sleep-targets;
        wantedBy = [ "sound.target" ] ++ sleep-targets;
      };
    };
    user.services = {
      # So that auto-mute mode is disabled on boot
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
  };
}
