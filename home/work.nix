{ pkgs, ... }:

{
  home.packages = with pkgs; [ pre-commit roomeqwizard ];
}
