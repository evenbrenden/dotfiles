{ config, pkgs, ... }:

{
  home.packages = [ pkgs.neovide ];
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
      in formatting ++ git-gutter ++ lsp ++ telescope;
    plugins = with pkgs.vimPlugins;
      let
        blue-mood-vim = pkgs.vimUtils.buildVimPlugin {
          name = "blue-mood-vim";
          src = pkgs.fetchFromGitHub {
            owner = "lmintmate";
            repo = "blue-mood-vim";
            rev = "0f67002c46d785299c3fdc37d075c38ee1b78655";
            sha256 = "sha256-PDciKSaxjHlhOk8ktXx8HjnfPCr9wgzCHebUjPlwj4M=";
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
        idris-vim
        idris2-vim
        kotlin-vim
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
        purescript-vim
        wmgraphviz-vim
      ] ++ telescope;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  xdg.configFile."nvim/lua/my-init.lua".source = ./my-init.lua;
  xdg.configFile."nvim/lua/my-lsp.lua".source = ./my-lsp.lua;
}
