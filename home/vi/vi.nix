{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    let
      formatting = [
        haskellPackages.brittany
        luaformatter
        nixfmt
        python39Packages.autopep8
        shfmt
      ];
      lsp =
        [ haskell-language-server python39Packages.python-lsp-server rnix-lsp ];
    in formatting ++ lsp;
  nixpkgs.overlays =
    [ (import ./haskell-language-server.nix) (import ./neovim.nix) ];
  programs.neovim = {
    enable = true;
    # https://github.com/nix-community/home-manager/pull/2716
    extraConfig = ''
      lua require 'neovim-init'
    '';
    plugins = with pkgs.vimPlugins;
      let
        completion = [ cmp-buffer cmp-nvim-lsp nvim-cmp vim-vsnip ];
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
        sfz-vim = pkgs.vimUtils.buildVimPlugin {
          name = "sfz-vim";
          src = pkgs.fetchFromGitHub {
            owner = "sfztools";
            repo = "sfz.vim";
            rev = "4ec4ad05beacd1ec69dc37dc8137f92d4c673fef";
            sha256 = "0brk6847n8wd8zb57wp7wjxyc7i3r0q29riv8ppy39j5lpdsbbss";
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
      in [
        fzf-vim
        neoformat
        nvim-lspconfig
        tcomment_vim
        sfz-vim
        vim-airline
        vim-better-whitespace
        neofsharp-vim
        vim-gitgutter
        vim-nix
        vim-pico8-syntax
        wmgraphviz-vim
      ] ++ completion;
  };
  xdg.configFile."nvim/lua/neovim-cmp.lua".source =
    ../dotfiles/neovim-cmp.lua;
  xdg.configFile."nvim/lua/neovim-init.lua".source =
    ../dotfiles/neovim-init.lua;
  xdg.configFile."nvim/lua/neovim-lsp.lua".source = ../dotfiles/neovim-lsp.lua;
}
