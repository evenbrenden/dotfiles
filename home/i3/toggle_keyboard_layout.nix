{ pkgs }:

pkgs.writeShellApplication {
  name = "toggle_keyboard_layout";
  runtimeInputs = with pkgs; [
    gawk
    procps # For pkill
    xorg.setxkbmap
  ];
  text = ''
    layout=$(setxkbmap -query | awk 'NR==3 {print $2}')

    if [[ $layout == 'us' ]]; then
        setxkbmap -layout norwerty
    else
        setxkbmap -layout us
    fi

    pkill -x -USR1 i3status
  '';
}
