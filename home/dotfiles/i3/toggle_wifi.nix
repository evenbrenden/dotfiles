{ pkgs }:
let
  nmcli = "${pkgs.networkmanager}/bin/nmcli";
  pkill = "${pkgs.procps}/bin/pkill";
in pkgs.writeScriptBin "toggle_wifi" ''
  #! /usr/bin/env bash

  state=$(${nmcli} radio wifi)

  if [[ $state == 'enabled' ]]; then
      ${nmcli} radio wifi off
  else
      ${nmcli} radio wifi on
  fi

  ${pkill} -x -USR1 i3status
''
