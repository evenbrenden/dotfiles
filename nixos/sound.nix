{ pkgs, ... }:

{
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudio.override { bluetoothSupport = true; };
    };
  };
  nixpkgs.config.pulseaudio = true; # Explicit PulseAudio support in applications
  services.pipewire.enable = false;
}
