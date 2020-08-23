{ pkgs, ... }:

{
  boot = {
    kernelPatches = [
      # https://github.com/gobenji/thinkpad-x1-gen7-sound (a9d0ccd308)
      {
        name = "alsa-hda-realtek-fix";
        patch = ./0001-ALSA-hda-realtek-Add-control-fixup-for-Lenovo-Thinkp.patch;
      }
      # Need this for applying the fixup until kernel 5.8 is available
      {
        name = "snd-sof-intel-hda-common-thing";
        patch = ./3e645a4add53eec22f3818c9da01c19191525096..b8d3ad51dfec3631763cfef3d30c16f40140058b.patch;
      }
    ];
    extraModprobeConfig = ''options snd_sof_intel_hda_common hda_model=alc285-tpx1-dual-speakers'';
    # Debug option for verifying that the fixup has been applied
    kernelParams = [ "snd_hda_codec.dyndbg=+p" ];
  };

  nixpkgs.overlays = [
    # PulseAudio 13.99
    (import ../../overlays/pulseaudio.nix)
  ];

  systemd = {
    services =
      let
        sleep_targets = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
      in
      {
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
        after = [ "multi-user.target" "sound.target" "graphical.target" ] ++ sleep_targets;
        wantedBy = [ "sound.target" ] ++ sleep_targets;
      };
    };
    user.services = {
      # So that headphone jack is made right on boot
      jiggle-headphone-jack = {
        description = "Jiggle headphone jack";
        script = ''
          python3 ${./set_pulseaudio_sink_port.py}
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
