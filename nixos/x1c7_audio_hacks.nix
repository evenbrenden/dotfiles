{ pkgs, ... }:

{
  boot.kernelPatches = [
    {
      name = "alsa-hda-realtek-fix-1";
      patch = ./0001-ALSA-hda-realtek-Fix-Lenovo-Thinkpad-X1-Carbon-7th-q.patch;
    }
    {
      name = "alsa-hda-realtek-fix-2";
      patch = ./0002-ALSA-hda-realtek-Replace-Lenovo-Thinkpad-X1-Carbon-7.patch;
    }
  ];

  nixpkgs.overlays = [
    (import ../overlays/pulseaudio.nix)
    (import ../overlays/sof-firmware.nix)
    (import ../overlays/alsa-ucm-conf.nix)
  ];

  systemd = {
    services = {
      headphones-clicks-fix = {
        description = "Headphones clicks fix";
        documentation = [ "https://gist.github.com/hamidzr/dd81e429dc86f4327ded7a2030e7d7d9#gistcomment-3154512" ];
        script = ''
          hda-verb /dev/snd/hwC0D0 0x1d SET_PIN_WIDGET_CONTROL 0x0
        '';
        path = [ pkgs.alsaTools ];
        after = [ "multi-user.target" ];
        wantedBy = [ "sound.target" ];
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
