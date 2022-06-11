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
          haskellPackages.brittany
          luaformatter
          nixfmt
          python39Packages.autopep8
          shfmt
        ];
        fzf-hoogle-vim = [
          fzf
          haskellPackages.hoogle # hoogle generate
          jq
        ];
        lsp = [
          haskell-language-server
          python39Packages.python-lsp-server
          rnix-lsp
          sumneko-lua-language-server
        ];
        telescope = [ clang fd nodejs ripgrep tree-sitter ];
      in fzf-hoogle-vim ++ formatting ++ lsp ++ telescope;
    plugins = with pkgs.vimPlugins;
      let
        fzf-hoogle-vim = [
          (pkgs.vimUtils.buildVimPluginFrom2Nix {
            name = "fzf-hoogle-vim";
            src = pkgs.fetchFromGitHub {
              owner = "monkoose";
              repo = "fzf-hoogle.vim";
              rev = "16c08d1534aea2cd1cea1a1e20783bd22f634c77";
              sha256 = "0k7cdi00ixqdkqmyqnapn5aplyn0w78iwvm7ifyi9j3smz57hzhf";
            };
          })
          fzf-vim
        ];
        neofsharp-vim = pkgs.vimUtils.buildVimPlugin {
          name = "neofsharp.vim";
          src = pkgs.fetchFromGitHub {
            owner = "adelarsq";
            repo = "neofsharp.vim";
            rev = "85d02f1dba209bbbad53ec9a41423e94672a5da5";
            sha256 = "06d52qr5wiar2j39nddnmqjh065xdzhlrx51sgm8d9g24akj8kq9";
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
        neoformat
        neofsharp-vim
        nvim-lspconfig
        sfz-vim
        tcomment_vim
        vim-airline
        vim-better-whitespace
        vim-gitgutter
        vim-hocon
        vim-markdown
        vim-nix
        vim-pico8-syntax
        wmgraphviz-vim
      ] ++ fzf-hoogle-vim ++ telescope;
  };
  home.file.".cache/fzf-hoogle.vim/placeholder".text = ""; # mkdir
  xdg.configFile."nvim/lua/my-init.lua".source = ./my-init.lua;
  xdg.configFile."nvim/lua/my-lsp.lua".source = ./my-lsp.lua;
}
