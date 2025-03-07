{ pkgs }:

pkgs.writeShellApplication {
  name = "git-replace";
  runtimeInputs = [ pkgs.git ];
  text = ''
    if [[ $# -ne 2 ]]
    then
        echo "Usage: git-replace <what> <with>"
        exit 0
    fi

    what=$1
    with=$2

    # PS: Use single quotes and escape all things regex
    git grep -l "$what" | xargs -r sed -i s/"$what"/"$with"/g
  '';
}
