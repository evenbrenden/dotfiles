# https://nixos.wiki/wiki/Visual_Studio_Code
# Known errors:
# -csharp extension fails to load. Not sure what it does, but ionide says that it needs it.
# -vsliveshare fails to use the keychain. Just close the error dialog and be on your way.
{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-vsliveshare.vsliveshare
      ionide.ionide-fsharp
      ms-dotnettools.csharp
    ];
  };
}
