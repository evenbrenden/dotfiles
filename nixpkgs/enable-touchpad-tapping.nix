{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "enable-touchpad-tapping";
  runtimeInputs = [ pkgs.xorg.xinput ];
  text = ''
    id=$(xinput list | grep Touchpad | sed -n 's/.*id=\([0-9]*\).*/\1/p')
    if [ -n "$id" ]; then
        xinput set-prop "$id" "libinput Tapping Enabled" 1
    else
        exit 1
    fi
  '';
}
