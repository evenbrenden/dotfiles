{ pkgs, ... }:

let
  prompt = let git-ps1-prefix = "PATH=$PATH:${pkgs.git}/bin"; # Needs git
  in ''
    source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
    DEFAULT_PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] "
    GIT_INFO="\$(${git-ps1-prefix} __git_ps1 '\[\e[3m\](%s)\[\033[0m\] ')"
    PS1="$DEFAULT_PS1""$GIT_INFO"
  '';
in {
  programs.bash = {
    enable = true;
    initExtra =
      builtins.concatStringsSep "\n" [ prompt (builtins.readFile ./bashrc) ];
    shellOptions = [ ]; # Set in initExtra
  };
}
