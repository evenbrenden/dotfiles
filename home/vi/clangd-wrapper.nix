{ pkgs }:

pkgs.writeShellScriptBin "clangd-wrapper" ''
  CCDB="compile_commands.json"
  if [ -f "$CCDB" ]; then
      DEFAULT_DRIVERS="/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang,/usr/bin/clang++,/usr/local/bin/gcc,/usr/local/bin/g++,/usr/local/bin/clang,/usr/local/bin/clang++"
      NIX_DRIVERS=$(jq -r '.[].command' "$CCDB" | grep -o '/nix/store[^ ]*bin/[^ ]*' | sort -u | paste -sd, -)
      if [ -n "$NIX_DRIVERS" ]; then
          ALL_DRIVERS=$(echo "$NIX_DRIVERS,$DEFAULT_DRIVERS" | tr ',' '\n' | sort -u | paste -sd, -)
      else
          ALL_DRIVERS="$DEFAULT_DRIVERS"
      fi
      exec clangd --query-driver="$ALL_DRIVERS" "$@"
  else
      exec clangd "$@"
  fi
''
