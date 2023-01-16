{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua require 'my-init'
    '';
    extraPackages = with pkgs;
      let
        formatting = [
          haskellPackages.fourmolu
          luaformatter
          nixfmt
          nodePackages.prettier
          python39Packages.autopep8
          scalafmt
          shfmt
        ];
        fzf-hoogle-vim = [
          fzf
          haskellPackages.hoogle # hoogle generate
          jq
        ];
        git-gutter = [ git ];
        lsp = [
          haskell-language-server
          metals
          python39Packages.python-lsp-server
          rnix-lsp
          sumneko-lua-language-server
          nodePackages.typescript
          nodePackages.typescript-language-server
        ];
        telescope = [ clang fd nodejs ripgrep tree-sitter ];
      in formatting ++ fzf-hoogle-vim ++ git-gutter ++ lsp ++ telescope;
    plugins = with pkgs.vimPlugins;
      let
        fzf-hoogle = [ fzf-hoogle-vim fzf-vim ];
        sfz-vim = pkgs.vimUtils.buildVimPlugin {
          name = "sfz-vim";
          src = pkgs.fetchFromGitHub {
            owner = "sfztools";
            repo = "sfz.vim";
            rev = "4ec4ad05beacd1ec69dc37dc8137f92d4c673fef";
            sha256 = "0brk6847n8wd8zb57wp7wjxyc7i3r0q29riv8ppy39j5lpdsbbss";
          };
        };
        telescope = [ nvim-treesitter telescope-nvim ];
      in [
        idris-vim
        idris2-vim
        kotlin-vim
        neoformat
        nvim-lspconfig
        nvim-solarized-lua
        sfz-vim
        suda-vim
        tcomment_vim
        vim-airline
        vim-auto-save
        vim-better-whitespace
        vim-dispatch
        vim-dispatch-neovim
        vim-gitgutter
        vim-markdown
        vim-nix
        vim-pico8-syntax
        purescript-vim
        wmgraphviz-vim
      ] ++ fzf-hoogle ++ telescope;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  home.file.".cache/fzf-hoogle.vim/placeholder".text = ""; # mkdir
  xdg.configFile."nvim/lua/my-init.lua".source = ./my-init.lua;
  xdg.configFile."nvim/lua/my-lsp.lua".source = ./my-lsp.lua;
}
