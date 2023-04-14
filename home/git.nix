{ pkgs, ... }:

let
  githubAddress = {
    user = "evenbrenden";
    host = "users.noreply.github.com";
  };
  codebergAddress = {
    user = "evenbrenden";
    host = "noreply.codeberg.org";
  };
  schibstedAddress = {
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
          email = githubAddress.user + "@" + githubAddress.host;
        };
      }
      {
        condition = "hasconfig:remote.*.url:**/*codeberg.org*/**";
        contents.user = {
          name = "Even Brenden";
          email = codebergAddress.user + "@" + codebergAddress.host;
        };
      }
      {
        condition = "hasconfig:remote.*.url:**/*github.schibsted.io*/**";
        contents.user = {
          name = "Even Brenden";
          email = schibstedAddress.user + "@" + schibstedAddress.host;
        };
      }
    ];
  };
}
