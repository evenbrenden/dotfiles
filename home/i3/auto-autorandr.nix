{ pkgs }:

pkgs.writeShellApplication {
  name = "auto-autorandr";
  runtimeInputs = with pkgs; [ autorandr ];
  text = ''
    if [ -z "$(autorandr --detected)" ]
    then
      autorandr --change clone-largest
    else
      autorandr --change
    fi
  '';
}
