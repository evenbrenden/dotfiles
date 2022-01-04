{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
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
    };
  };
}
