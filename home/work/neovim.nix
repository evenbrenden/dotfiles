{ config, pkgs, ... }:

# Ionide status: FSAC is not updated when a file is edited
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins;
      let
        ionide-vim = pkgs.vimUtils.buildVimPlugin {
          name = "ionide-vim";
          src = pkgs.fetchFromGitHub {
            owner = "ionide";
            repo = "Ionide-vim";
            rev = "6eb5de0b13cee781d0ccc0559d614ea032967293";
            sha256 = "06psx9r82m29vs44r3n0diliiwg1dnv6gj0n6l9a9p5w2f68zjm7";
          };
        };

      in [
        deoplete-nvim
        ionide-vim # dotnet tool install -g fsautocomplete
      ];
  };
}
