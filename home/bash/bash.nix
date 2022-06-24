{ pkgs, ... }:

let
  prompt = ''
    source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
    DEFAULT_PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] "
    GIT_INFO="\$(__git_ps1 '\[\e[3m\](%s)\[\033[0m\] ')"
    PS1="$DEFAULT_PS1""$GIT_INFO"
  '';
in {
  programs.bash = {
    enable = true;
    initExtra =
      builtins.concatStringsSep "\n" [ prompt (builtins.readFile ./bashrc) ];
    shellOptions = [ ]; # Set in initExtra
  };
  home.packages = [
    pkgs.git # For git-prompt.sh
  ];
}
