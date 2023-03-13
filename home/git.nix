{ pkgs, ... }:

let
  privateAddress = {
    user = "evenbrenden";
    host = "gmail.com";
  };
  workAddress = {
    user = "even.steen.brenden";
    host = "schibsted.com";
  };
in {
  home.packages = [ (import ./git-replace.nix { inherit pkgs; }) pkgs.tig ];
  programs.git = {
    enable = true;
    extraConfig = {
      core.whitespace = "trailing-space";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "simple";
    };
    ignores = let
      metals = [ ".bloop/" ".metals/" "project/.bloop/" "project/metals.sbt" "project/project/" ];
      sumneko-lua = [ ".luarc.json" ];
    in [ ".direnv/" ".envrc" "*.swp" ] ++ metals ++ sumneko-lua;
    includes = [
      {
        condition = "hasconfig:remote.*.url:**/*github.com*/**";
        contents.user = {
          name = "Even Brenden";
          email = privateAddress.user + "@" + privateAddress.host;
        };
      }
      {
        condition = "hasconfig:remote.*.url:**/*codeberg.org*/**";
        contents.user = {
          name = "Even Brenden";
          email = privateAddress.user + "@" + privateAddress.host;
        };
      }
      {
        condition = "hasconfig:remote.*.url:**/*github.schibsted.io*/**";
        contents.user = {
          name = "Even Brenden";
          email = workAddress.user + "@" + workAddress.host;
        };
      }
    ];
  };
}
