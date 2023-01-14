{ pkgs, ... }:

{
  systemd = {
    services = let
      sleep-targets =
        [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
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
        path = [ pkgs.alsaTools ];
        after = [ "multi-user.target" "sound.target" "graphical.target" ]
          ++ sleep-targets;
        wantedBy = [ "sound.target" ] ++ sleep-targets;
      };
    };
    user.services = {
      # So that headphone jack is made right on boot
      jiggle-headphone-jack = {
        description = "Jiggle headphone jack";
        script = ''
          python3 ${./set-pulseaudio-sink-port.py}
        '';
        path = [ pkgs.pulseaudio pkgs.python3 ];
        after = [ "default.target" ];
        wantedBy = [ "pulseaudio.service" ];
      };
      # So that mic mute LED is made right on boot
      jiggle-mic-mute-led = {
        description = "Jiggle mic mute LED";
        script = ''
          pactl set-source-mute @DEFAULT_SOURCE@ toggle
          pactl set-source-mute @DEFAULT_SOURCE@ toggle
        '';
        path = [ pkgs.pulseaudio ];
        after = [ "default.target" ];
        wantedBy = [ "pulseaudio.service" ];
      };
    };
  };
}
