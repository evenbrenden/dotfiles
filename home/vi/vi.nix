{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua require 'my-init'
    '';
    extraPackages = with pkgs;
      let
        copilot = [ nodejs ];
        formatting = [
          haskellPackages.fourmolu
          luaformatter
          nixfmt
          nodePackages.prettier
          python39Packages.autopep8
          scalafmt
          shfmt
        ];
        git-gutter = [ git ];
        lsp = [
          haskell-language-server
          lua-language-server
          metals
          nil
          python39Packages.python-lsp-server
          nodePackages.typescript
          nodePackages.typescript-language-server
          yaml-language-server
        ];
        telescope = [ clang fd nodejs ripgrep tree-sitter ];
      in copilot ++ formatting ++ git-gutter ++ lsp ++ telescope;
    plugins = with pkgs.vimPlugins;
      let
        blue-mood-vim = pkgs.vimUtils.buildVimPlugin {
          name = "blue-mood-vim";
          src = pkgs.fetchFromGitHub {
            owner = "evenbrenden";
            repo = "blue-mood-vim";
            rev = "57fa7d9e0f11b78179e59b27a89ccdf63e158e67";
            sha256 = "sha256-C5u5M2aihTKpJO7u+AusouuoVT8sI4omtml2cKjomNQ=";
          };
        };
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
        blue-mood-vim
        copilot-vim
        idris2-vim
        neoformat
        nvim-lspconfig
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
        vim-polyglot
        purescript-vim
        wmgraphviz-vim
      ] ++ telescope;
  };
  xdg.configFile = {
    "nvim/lua/my-init.lua".source = ./my-init.lua;
    "nvim/lua/my-lsp.lua".source = ./my-lsp.lua;
    # https://discourse.nixos.org/t/conflicts-between-treesitter-withallgrammars-and-builtin-neovim-parsers-lua-c/33536/3
    "nvim/parser".source = "${
        pkgs.symlinkJoin {
          name = "treesitter-parsers";
          paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [ c lua query ])).dependencies;
        }
      }/parser";
  };
}
