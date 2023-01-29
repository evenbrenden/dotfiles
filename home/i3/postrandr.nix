{ pkgs }:

pkgs.writeShellApplication {
  name = "postrandr";
  runtimeInputs = with pkgs; [ hsetroot ];
  text = ''
    # "Chinese violet"
    hsetroot -solid '#856088'
  '';
}
