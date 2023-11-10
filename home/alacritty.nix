{ config, pkgs, ... }:

let
  alacritty-theme = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "808b81b2e88884e8eca5d951b89f54983fa6c237";
    sha256 = "sha256-g5tM6VBPLXin5s7X0PpzWOOGTEwHpVUurWOPqM/O13A=";
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${alacritty-theme}/themes/alabaster.yaml" ];
      font = {
        normal = { family = "DejaVu Sans Mono"; };
        size = 12.0;
      };
    };
  };
}
