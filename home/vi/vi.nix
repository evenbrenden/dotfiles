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
          nixfmt-classic
          nodePackages.prettier
          python312Packages.autopep8
          rustfmt
          shfmt
        ];
        git-gutter = [ git ];
        lsp = [
          llvmPackages_19.clang-tools
          haskell-language-server
          idris2Packages.idris2Lsp
          lua-language-server
          nil
          (pkgs.python3.withPackages (pp: [ pp.pylsp-mypy pp.python-lsp-server ]))
          rust-analyzer
          nodePackages.typescript
          nodePackages.typescript-language-server
          yaml-language-server
        ];
        telescope = [ clang fd nodejs ripgrep tree-sitter ];
      in copilot ++ formatting ++ git-gutter ++ lsp ++ telescope;
    plugins = with pkgs.vimPlugins;
      let
        alabaster-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "alabaster.nvim";
          src = pkgs.fetchFromSourcehut {
            owner = "~p00f";
            repo = "alabaster.nvim";
            rev = "49864f478a2d33fdea93ca3523c475a7cc54b168";
            sha256 = "sha256-qEeY6uCbWxStrbAt3ADliVbOELyuuY4GwHkmsQMkfHM=";
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
      in [
        alabaster-nvim
        copilot-vim
        graphviz-vim
        hurl
        idris2-vim
        neoformat
        nvim-lspconfig
        nvim-treesitter
        sfz-vim
        tcomment_vim
        telescope-nvim
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
        vim-suda
      ];
  };

  xdg.configFile = {
    "nvim/lua/my-assistants.lua".source = ./my-assistants.lua;
    "nvim/lua/my-init.lua".source = ./my-init.lua;
    "nvim/lua/my-lsp.lua".source = ./my-lsp.lua;
    # https://discourse.nixos.org/t/conflicts-between-treesitter-withallgrammars-and-builtin-neovim-parsers-lua-c/33536/3
    "nvim/parser".source = "${
        pkgs.symlinkJoin {
          name = "treesitter-parsers";
          paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins
            (plugins: with plugins; [ c lua query markdown vim vimdoc yaml ])).dependencies;
        }
      }/parser";
  };
}
