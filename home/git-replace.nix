{ pkgs }:
let git = "${pkgs.git}/bin/git";
in pkgs.writeScriptBin "git-replace" ''
  #!/usr/bin/env bash

  if [[ $# -ne 2 ]]; then
      echo "Usage: git-replace WHAT WITH"
      exit 0
  fi
  what=$1
  with=$2

  # Remember: Use single quotes and escape all things regex
  ${git} grep -l "$what" | xargs -r sed -i s/"$what"/"$with"/g
''
