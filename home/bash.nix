{ pkgs, ... }:

let
  aliases = {
    clamdscan = "clamdscan --fdpass";
    cp = "cp --interactive";
    diff = "diff --color=auto";
    git-root = ''cd "$(git rev-parse --show-toplevel)"'';
    ls = "ls -Ah --color=auto";
    mv = "mv --interactive";
    # --no-update-dir-modtime while waiting for backend support
    rclone-sync = "rclone sync --create-empty-src-dirs --no-update-dir-modtime --interactive";
    rm = "rm --interactive=once";
    vi = "nvim";
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
    GIT_INFO='(%s)\[\033[0m\] '
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_STATESEPARATOR=""
    PROMPT_COMMAND='history -a; __git_ps1 "$DEFAULT_PS1" "" "$GIT_INFO"'
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
  fzf = ''
    eval "$(${pkgs.lib.getExe pkgs.fzf} --bash)"
  '';
in {
  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyFileSize = 100000;
    historySize = 10000;
    initExtra = builtins.concatStringsSep "\n" [ history-search prompt shell-variables-fff shell-variables-misc fzf ];
    shellAliases = aliases;
    shellOptions = [ "histappend" ];
  };
  home.packages = with pkgs;
    [
      git # For git-prompt.sh
    ];
}
