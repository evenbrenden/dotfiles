{ config, pkgs, ... }:

{
  nixpkgs.overlays = [ (import ./neovim.nix) ];
  programs.neovim = {
    enable = true;
    # https://github.com/nix-community/home-manager/pull/2716
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
        fzf-hoogle-vim = [ fzf haskellPackages.hoogle jq ];
        lsp = [
          glow
          haskell-language-server
          python39Packages.python-lsp-server
          rnix-lsp
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
        glow-hover = pkgs.vimUtils.buildVimPlugin {
          name = "glow-hover";
          src = pkgs.fetchFromGitHub {
            owner = "JASONews";
            repo = "glow-hover.nvim";
            rev = "c8d0cae5d05c658f4701425b05f1432121092c68";
            sha256 = "04cif3frm4xfzc5rllp57zn11wi6pkydd7swghq3pcavgfmiykm4";
          };
        };
        nvim-lspconfig = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "nvim-lspconfig";
          version = "2022-04-17";
          src = pkgs.fetchFromGitHub {
            owner = "neovim";
            repo = "nvim-lspconfig";
            rev = "99596a8cabb050c6eab2c049e9acde48f42aafa4";
            sha256 = "1x9b87d965q9a7a726dw6q6k0lady04acg0n4c1shjwin7cl6kx9";
          };
        };
        neofsharp-vim = pkgs.vimUtils.buildVimPlugin {
          name = "neofsharp.vim";
          src = pkgs.fetchFromGitHub {
            owner = "adelarsq";
            repo = "neofsharp.vim";
            rev = "85d02f1dba209bbbad53ec9a41423e94672a5da5";
            sha256 = "06d52qr5wiar2j39nddnmqjh065xdzhlrx51sgm8d9g24akj8kq9";
          };
        };
        # https://github.com/nvim-treesitter/nvim-treesitter/pull/1905
        nvim-treesitter = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "nvim-treesitter";
          version = "2022-05-13";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-treesitter";
            repo = "nvim-treesitter";
            rev = "f1373051e554cc4642cda719c8023e4e8508eb2d";
            sha256 = "1jfcjwyp57scwj164pxzh376mh2i4nx2sxx0gpihl3r4m067gb84";
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
        vim-airline = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-airline";
          version = "2022-05-06";
          src = pkgs.fetchFromGitHub {
            owner = "vim-airline";
            repo = "vim-airline";
            rev = "c4655701431a9c79704c827fd88a4783ec946879";
            sha256 = "1qsr3kkfx5vbhmnym0id2h9mph8bw6g75vwpqfi9vfmbg4fddh3l";
          };
        };
      in [
        glow-hover
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
