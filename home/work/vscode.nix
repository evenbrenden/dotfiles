# https://nixos.wiki/wiki/Visual_Studio_Code
{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [ pkgs.vscode-extensions.ms-vsliveshare.vsliveshare ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "ionide-fsharp";
          publisher = "ionide";
          version = "4.17.0";
          sha256 = "1z1bdrbybnx3i4x461dbzz0a4p5v2rndszm7dwk1sqv6j8fixc4b";
        }
        {
          name = "csharp";
          publisher = "ms-dotnettools";
          version = "1.23.4";
          sha256 = "1x90r4c90ylvwx4bmr6pmlzmx55vbkc91a4sqhi129rdvq2miv4w";
        }
      ];
  };
}
