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
    extraConfig = pkgs.lib.strings.fileContents ../dotfiles/neovim-init.vim;
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
        vim-fsharp = pkgs.vimUtils.buildVimPlugin {
          name = "vim-fsharp";
          src = pkgs.fetchFromGitHub {
            owner = "PhilT";
            repo = "vim-fsharp";
            rev = "ef3b89768dbd7cb944cad0fb5131342d95ab58d6";
            sha256 = "1k9rdpf0c9hag6b10l8b8k92563vx2f4jdm5mbz7cl2g8p3xb3c6";
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
        vim-fsharp
        vim-gitgutter
        vim-nix
        vim-pico8-syntax
        wmgraphviz-vim
      ] ++ completion;
  };
  # https://github.com/nix-community/home-manager/pull/2716
  xdg.configFile."nvim/lua/neovim-completion.lua".source =
    ../dotfiles/neovim-completion.lua;
  xdg.configFile."nvim/lua/neovim-init.lua".source =
    ../dotfiles/neovim-init.lua;
  xdg.configFile."nvim/lua/neovim-lsp.lua".source = ../dotfiles/neovim-lsp.lua;
}
