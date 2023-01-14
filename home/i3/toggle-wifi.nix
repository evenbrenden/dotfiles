{ pkgs }:

pkgs.writeShellApplication {
  name = "toggle-wifi";
  runtimeInputs = with pkgs; [
    networkmanager
    procps # For pkill
  ];
  text = ''
    state=$(nmcli radio wifi)

    if [[ $state == 'enabled' ]]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi

    pkill -x -USR1 i3status
  '';
}
