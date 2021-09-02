{ pkgs }:
let
  git = "${pkgs.git}/bin/git";
in
  pkgs.writeScriptBin
    "git-replace"
    ''
      #!/usr/bin/env bash

      if [[ $# -ne 2 ]]
      then
        echo "Usage: git-replace FROM TO"
        exit 0
      fi
      from=$1
      to=$2

      ${git} grep -l "$from" | xargs sed -i "s/$from/$to/g"
    ''
