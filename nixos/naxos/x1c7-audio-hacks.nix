{ pkgs, ... }:

{
  boot = {
    kernelPatches = [
      # https://lore.kernel.org/alsa-devel/s5hlfhsbn0u.wl-tiwai@suse.de/ (will be in v5.9-rc4)
      {
        name = "Add-control-fixup-for-Lenovo-Thinkpad-X1-Carbon-7th";
        patch = ./b79de57b4378a93115307be6962d05b099eb0f37..6a6660d049f88b89fd9a4b9db3581b245f7782fa.patch;
      }
    ];
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
