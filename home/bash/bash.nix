{ pkgs, ... }:

let
  set-prompt = ''
    source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
    DEFAULT_PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
    GIT_INFO='\[\e[3m\](%s)\[\033[0m\] '
    PROMPT_COMMAND='__git_ps1 "$DEFAULT_PS1" "" "$GIT_INFO"'
  '';
in {
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyFileSize = 100000;
    historySize = 10000;
    initExtra = builtins.concatStringsSep "\n" [
      set-prompt
      (builtins.readFile ./bashrc)
    ];
    shellOptions = [ "histappend" ];
  };
  home.packages = [
    pkgs.git # For git-prompt.sh
  ];
}
