{ pkgs, ... }:

let
  aliases-coreutils = {
    cp = "cp --interactive";
    ls = "ls -Ah --color=auto";
    mv = "mv --interactive";
    rm = "rm --interactive=once";
  };
  aliases-misc = {
    rclone-sync = "rclone sync --create-empty-src-dirs --interactive";
    vi = "nvim";
    vim = "nvim";
    vimdiff = "nvim -d";
    xclip = "xclip -selection clipboard";
  };
  history-search = ''
    bind '"\eOA": history-search-backward'
    bind '"\e[A": history-search-backward'
    bind '"\eOB": history-search-forward'
    bind '"\e[B": history-search-forward'
  '';
  prompt = ''
    source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
    DEFAULT_PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
    GIT_INFO='\[\e[3m\](%s)\[\033[0m\] '
    PROMPT_COMMAND='__git_ps1 "$DEFAULT_PS1" "" "$GIT_INFO"'
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
      prompt
      shell-variables-fff
      shell-variables-misc
    ];
    shellAliases = aliases-coreutils // aliases-misc;
    shellOptions = [ "histappend" ];
  };
  home.packages = with pkgs;
    [
      git # For git-prompt.sh
    ];
}
