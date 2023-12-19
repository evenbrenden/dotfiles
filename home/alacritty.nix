let
  blue-mood = builtins.fetchGit {
    url = "git@codeberg.org:evenbrenden/blue-mood-alacritty.git";
    rev = "ea964a846560fe44da85ab4c4c50da63588c08fb";
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${blue-mood}/blue-mood.yml" ];
      font = {
        normal = { family = "DejaVu Sans Mono"; };
        size = 12.0;
      };
    };
  };
}
