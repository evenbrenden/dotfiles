{ pkgs, ... }:

{
  home.packages = let
    git-replace = pkgs.writeShellApplication {
      name = "git-replace";
      runtimeInputs = with pkgs; [ git ];
      text = ''
        if [[ $# -ne 2 ]]
        then
            echo "Usage: git-replace <what> <with>"
            exit 0
        fi

        what=$1
        with=$2

        # PS: Use single quotes and escape all things regex
        git grep -l "$what" | xargs -r sed -i s/"$what"/"$with"/g
      '';
    };
  in [ git-replace pkgs.tig ];

  programs.git = {
    enable = true;
    extraConfig = {
      core.whitespace = "trailing-space";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "simple";
      url = { "git@github.schibsted.io:" = { insteadOf = "https://github.schibsted.io/"; }; };
    };
    ignores = let metals = [ ".bloop" ".metals" "metals.sbt" ];
    in [ ".aider*" ".direnv" ".envrc" ".luarc.json" "*.swp" ] ++ metals;
    includes = let
      codebergAddress = {
        user = "evenbrenden";
        host = "noreply.codeberg.org";
      };
      githubAddress = {
        user = "evenbrenden";
        host = "users.noreply.github.com";
      };
      schibstedAddress = {
        user = "even.steen.brenden";
        host = "schibsted.com";
      };
    in [
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
