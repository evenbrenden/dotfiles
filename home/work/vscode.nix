# https://nixos.wiki/wiki/Visual_Studio_Code
{ pkgs, ... }:

let
  extensions = with pkgs.vscode-extensions; [
    ms-vsliveshare.vsliveshare
    ionide.ionide-fsharp
    ms-dotnettools.csharp
  ];
  vscode-with-extensions =
    pkgs.vscode-with-extensions.override { vscodeExtensions = extensions; };
in { home.packages = with pkgs; [ vscode-with-extensions ]; }
