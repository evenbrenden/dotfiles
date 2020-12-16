{ config, lib, pkgs, ... }:

with lib;

let
  # https://github.com/fsprojects/fsharp-language-server#installation
  fsharp-language-server = "${config.home.homeDirectory}/bin/fsharp-language-server/FSharpLanguageServer.dll";

  cfg = config.programs.vim-fsharp-lsp;
in
  {
    options.programs.vim-fsharp-lsp = {
      enable = mkEnableOption "Neovim F# LSP";
    };

    config = mkIf cfg.enable {
      programs.neovim = with pkgs.vimPlugins; {
        extraConfig = ''
          " LanguageClient-neovim
          noremap <silent><Leader>h :call LanguageClient#textDocument_hover()<CR>
          noremap <silent><Leader>d :call LanguageClient#textDocument_definition()<CR>
          noremap <silent><Leader>r :call LanguageClient#textDocument_references()<CR>
          noremap <silent><Leader>n :call LanguageClient#textDocument_rename()<CR>
          noremap <silent><Leader>c :call LanguageClient_contextMenu()<CR>
          let g:LanguageClient_serverCommands = {
              \ 'fsharp': ['dotnet', '${fsharp-language-server}'],
              \ }
          let g:LanguageClient_hoverPreview = 'Always'
        '';
        plugins = [ LanguageClient-neovim ];
      };
    };
  }

