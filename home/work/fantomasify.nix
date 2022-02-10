{ pkgs }:
let git = "${pkgs.git}/bin/git";
in pkgs.writeScriptBin "fantomasify" ''
  #! /usr/bin/env bash

  for file in $(git diff --name-only)
  do
      dotnet fantomas $file
  done
''
