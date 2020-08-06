{ pkgs, ... }:

{
  boot.kernelPatches = [
    {
      name = "alsa-hda-realtek-fix";
      patch = ./0002-ALSA-hda-realtek-Replace-Lenovo-Thinkpad-X1-Carbon-7.patch;
    }
  ];

  nixpkgs.overlays = [
    (import ../overlays/pulseaudio.nix)
    (import ../overlays/alsa-ucm-conf.nix)
  ];

  systemd = {
    services = {
      # There are clicks on right channel of the headphone jack when there's
      # transient silence. This can be heard in the beginning of the the clip
      # in https://youtu.be/2ZrWHtvSog4. Running the following command makes
      # them less noticable, but not completely gone. It's not that bad tbh.
      reduce-headphone-jack-clicks = {
        description = "Reduce headphone jack clicks";
        script = ''
          # Played around with hda-analyzer and found that this makes a difference
          hda-verb /dev/snd/hwC0D0 0x1a SET_PIN_WIDGET_CONTROL 0x0
          # https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3154512
          hda-verb /dev/snd/hwC0D0 0x1d SET_PIN_WIDGET_CONTROL 0x0
        '';
        path = [ pkgs.alsaTools ];
        after = [ "multi-user.target" "sound.target" "graphical.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
        wantedBy = [ "sound.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
      };
    };
    user.services = {
      set-pulseaudio-sink-port = {
        description = "Set pulseaudio sink port";
        script = ''
          python3 ${./set_pulseaudio_sink_port.py}
        '';
        path = [ pkgs.pulseaudio pkgs.python3 ];
        after = [ "default.target" ];
        wantedBy = [ "pulseaudio.service" ];
      };
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
