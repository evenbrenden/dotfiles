{ pkgs, ... }:

let
  aliases = {
    cp = "cp --interactive";
    diff = "diff --color=auto";
    ls = "ls -Ah --color=auto";
    mv = "mv --interactive";
    rclone-sync = "rclone sync --create-empty-src-dirs --interactive";
    rm = "rm --interactive=once";
    xclip = "xclip -selection clipboard";
  };
  history-search = ''
    bind '"\eOA": history-search-backward'
    bind '"\e[A": history-search-backward'
    bind '"\eOB": history-search-forward'
    bind '"\e[B": history-search-forward'
  '';
  path = ''
    export PATH=$PATH:$HOME/bin
  '';
  prompt = ''
    source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
    DEFAULT_PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
    if [ "$SHLVL" != '1' ]; then
      SHELL_LEVEL="\[\e[3m\]($SHLVL)\[\033[0m\] "
    fi
    GIT_INFO='\[\e[3m\](%s)\[\033[0m\] '
    PROMPT_COMMAND='__git_ps1 "$DEFAULT_PS1" "$SHELL_LEVEL" "$GIT_INFO"'
  '';
  shell-variables-fff = ''
    export FFF_FAV1=~/Downloads
    export FFF_FAV2=/media/ted15/music
    # https://github.com/dylanaraps/fff/issues/180
    export FFF_KEY_BULK_RENAME="off"
    export FFF_KEY_BULK_RENAME_ALL="off"
  '';
  shell-variables-misc = ''
    export EDITOR=nvim
    export LESS=-Ri
  '';
in {
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyFileSize = 100000;
    historySize = 10000;
    initExtra = builtins.concatStringsSep "\n" [
      history-search
      path
      prompt
      shell-variables-fff
      shell-variables-misc
    ];
    shellAliases = aliases;
    shellOptions = [ "histappend" ];
  };
  home.packages = with pkgs;
    [
      git # For git-prompt.sh
    ];
}
