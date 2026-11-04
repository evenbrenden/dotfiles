{ pkgs }:

pkgs.writeShellApplication {
  name = "clear-downloads";
  text = ''
    directory="$HOME/Downloads"

    files=$(find "$directory" -mindepth 1)
    if [[ -z "$files" ]]; then
        exit 0
    fi
    echo "$files"

    read -rp "Delete? " answer
    if [[ $answer == [yY] ]]; then
        find "$directory" -mindepth 1 -delete
    fi
  '';
}
