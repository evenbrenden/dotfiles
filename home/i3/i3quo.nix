{ pkgs }:

pkgs.writeShellApplication {
  name = "i3quo";
  runtimeInputs = with pkgs; [
    gawk
    dbus # dunstctl needs dbus-send
    dunst
    i3status
    pulseaudio
    xorg.setxkbmap
  ];
  text = ''
    # https://docs.slackware.com/howtos:window_managers:keyboard_layout_in_i3
    i3status | while :; do
        read -r line

        NOTIFY_PAUSED=$(dunstctl is-paused)
        if [[ $NOTIFY_PAUSED = 'false' ]]; then
            NOTIFY_STATE_PRINT='notify'
            NOTIFY_STATE_COLOR='#ffffff'
        elif [[ $NOTIFY_PAUSED = 'true' ]]; then
            NOTIFY_STATE_PRINT='paused'
            NOTIFY_STATE_COLOR='#ff0000'
        fi
        NOTIFY_ITEM="{ \"full_text\": \"$NOTIFY_STATE_PRINT\", \"color\":\"$NOTIFY_STATE_COLOR\" }"

        KEYBOARD_LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}')
        KEYBOARD_LAYOUT_COLOR='#ff00ff'
        KEYBOARD_ITEM="{ \"full_text\": \"$KEYBOARD_LAYOUT\", \"color\":\"$KEYBOARD_LAYOUT_COLOR\" }"

        MIC_MUTED=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
        if [[ $MIC_MUTED = 'yes' ]]; then
            MIC_MUTE_PRINT='off'
            MIC_MUTE_COLOR='#ffffff'
        elif [[ $MIC_MUTED = 'no' ]]; then
            MIC_MUTE_PRINT='mic'
            MIC_MUTE_COLOR='#ff0000'
        fi
        MIC_MUTE_ITEM="{ \"full_text\": \"$MIC_MUTE_PRINT\", \"color\":\"$MIC_MUTE_COLOR\" }"

        data="[$NOTIFY_ITEM, $KEYBOARD_ITEM, $MIC_MUTE_ITEM,"
        echo "''${line/[/$data}" || exit 1
    done
  '';
}
