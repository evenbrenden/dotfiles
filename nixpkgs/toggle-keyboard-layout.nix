{ pkgs }:

pkgs.writeShellApplication {
  name = "toggle-keyboard-layout";
  runtimeInputs = with pkgs; [ gawk procps xorg.setxkbmap ];
  text = ''
    layout=$(setxkbmap -query | awk 'NR==3 {print $2}')

    if [[ $layout == 'us' ]]; then
        setxkbmap -layout no -variant norwerty || setxkbmap -layout norwerty || setxkbmap -layout no
    else
        setxkbmap -layout us
    fi

    pkill -x -USR1 i3status
  '';
}
