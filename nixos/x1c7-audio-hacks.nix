{ pkgs, ... }:

{
  boot = {
    kernelPatches = [
      # https://github.com/gobenji/thinkpad-x1-gen7-sound (adfee57)
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
    (import ../overlays/pulseaudio.nix)
  ];

  systemd = {
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
