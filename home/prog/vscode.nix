{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions =
      [ pkgs.vscode-extensions.ms-vsliveshare.vsliveshare ]
      ++
      pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
        {
          name = "vscode-graphviz";
          publisher = "joaompinto";
          version = "0.0.6";
          sha256 = "17z5zgr8l94mj8dgqxwsrpixnkz0778fp1g4rxc7i56wb1zbik3w";
        }
      ];
    userSettings = {
      "editor.occurrencesHighlight" = true;
      "editor.renderLineHighlight" = "none";
      "editor.copyWithSyntaxHighlighting" = false;
      "editor.highlightActiveIndentGuide" = false;
      "workbench.editor.highlightModifiedTabs" = true;
      "editor.renderIndentGuides" = false;
      "editor.cursorBlinking" = "solid";
      "editor.cursorStyle" = "block";
      "editor.minimap.enabled" = false;
      "editor.matchBrackets" = "never";
      "editor.links" = false;
      "workbench.editor.enablePreview" = false;
      "FSharp.useSdkScripts" = true;
    };
  };
}
