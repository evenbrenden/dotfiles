{ pkgs, ... }:

{
  home.packages = [
    pkgs.git-replace
    pkgs.tig
  ];

  programs.git = {
    enable = true;
    settings = {
      commit.gpgSign = true;
      core.whitespace = "trailing-space";
      gpg.format = "ssh";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "simple";
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIk8RlmFgSSsa2J+P/eTdHEsOPmHPEkOYkYYYWcRR5gn evenbrenden";
    };
    ignores = [
      ".clangd"
      ".claude"
      "compile_commands.json"
      ".direnv"
      ".envrc"
      ".luarc.json"
      ".nix"
      "*.swp"
      ".venv"
    ];
    includes =
      let
        codebergAddress = {
          user = "evenbrenden";
          host = "noreply.codeberg.org";
        };
        githubAddress = {
          user = "evenbrenden";
          host = "users.noreply.github.com";
        };
      in
      [
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
