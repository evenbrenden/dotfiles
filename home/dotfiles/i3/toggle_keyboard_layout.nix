{ pkgs }:
let
  awk = "${pkgs.gawk}/bin/awk";
  pkill = "${pkgs.procps}/bin/pkill";
  setxkbmap = "${pkgs.xorg.setxkbmap}/bin/setxkbmap";
in pkgs.writeScriptBin "toggle_keyboard_layout" ''
  #! /usr/bin/env bash

  layout=$(${setxkbmap} -query | ${awk} 'NR==3 {print $2}')

  if [[ $layout == 'us' ]]; then
      ${setxkbmap} -layout norwerty
  else
      ${setxkbmap} -layout us
  fi

  ${pkill} -x -USR1 i3status
''
