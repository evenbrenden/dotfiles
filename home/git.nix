{ pkgs, ... }:

{
  home.packages = [ pkgs.git-replace pkgs.tig ];

  programs.git = {
    enable = true;
    settings = {
      core.whitespace = "trailing-space";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "simple";
    };
    ignores = [ ".aider*" ".clangd" "compile_commands.json" ".direnv" ".envrc" ".luarc.json" ".nix" "*.swp" ".venv" ];
    includes = let
      codebergAddress = {
        user = "evenbrenden";
        host = "noreply.codeberg.org";
      };
      githubAddress = {
        user = "evenbrenden";
        host = "users.noreply.github.com";
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
    ];
  };
}
