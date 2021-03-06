{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = pkgs.lib.strings.fileContents ./dotfiles/init.vim;
    plugins = with pkgs.vimPlugins;
      let
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
            owner = "wsdjeg";
            repo = "vim-fsharp";
            rev = "a4255ba4866fa5aba91fec342f98964cffbbc542";
            sha256 = "0vlr90x4rp30a98k0g1g0fmwmp0slblp74fr8zaclyvbc8kwzimc";
          };
        };
      in
      [
        fzf-vim
        tcomment_vim
        sfz-vim
        vim-airline
        vim-fsharp
        vim-gitgutter
        vim-nix
        vim-pico8-syntax
        wmgraphviz-vim
      ];
  };
}
