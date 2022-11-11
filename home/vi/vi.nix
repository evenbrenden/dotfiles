{ config, pkgs, ... }:

{
  nixpkgs.overlays = [ (import ./neovim.nix) ];
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
          unstable.haskell-language-server
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
        defaultish = pkgs.vimUtils.buildVimPlugin {
          name = "defaultish";
          src = ./defaultish;
        };
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
        nvim-tree-lua = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-tree.lua";
          src = pkgs.fetchFromGitHub {
            owner = "kyazdani42";
            repo = "nvim-tree.lua";
            rev = "7e892767bdd9660b7880cf3627d454cfbc701e9b";
            sha256 = "sha256-n/EIlpVbcU7St0lBOb4dUm0EkwcNiZRpfZTrpDjdiUo=";
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
        vim-auto-save = pkgs.vimUtils.buildVimPlugin {
          name = "vim-auto-save";
          src = pkgs.fetchFromGitHub {
            owner = "907th";
            repo = "vim-auto-save";
            rev = "2e3e54ea4c0fc946c21b0a4ee4c1c295ba736ee8";
            sha256 = "sha256-sCUEGcIyJHs/Qqgl6246ZWcNokTR0h9+AA6SYzyMhtU=";
          };
        };
      in [
        defaultish
        kotlin-vim
        neoformat
        neofsharp-vim
        nvim-lspconfig
        nvim-tree-lua
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
      ] ++ fzf-hoogle-vim ++ telescope;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  home.file.".cache/fzf-hoogle.vim/placeholder".text = ""; # mkdir
  xdg.configFile."nvim/lua/my-init.lua".source = ./my-init.lua;
  xdg.configFile."nvim/lua/my-lsp.lua".source = ./my-lsp.lua;
}
