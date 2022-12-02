{ pkgs, ... }:

{
  home.packages = [ (import ./git-replace.nix { inherit pkgs; }) pkgs.tig ];
  programs.git = {
    enable = true;
    extraConfig = {
      core = { whitespace = "trailing-space"; };
      init = { defaultBranch = "main"; };
      pull = { rebase = true; };
      push = { default = "simple"; };
      user = { name = "Even Brenden"; };
      # git config user.email [ADDRESS]
    };
    ignores = [ ".direnv/" ".envrc" "*.swp" ];
  };
}
