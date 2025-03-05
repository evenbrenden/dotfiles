{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.steam-run ];
  programs.steam.enable = true;
  hardware = {
    graphics.enable32Bit = true;
    steam-hardware.enable = true;
  };
}
