{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ alsa-utils pavucontrol ];
  hardware = {
    bluetooth.enable = true;
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
