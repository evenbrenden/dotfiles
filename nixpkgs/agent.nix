{ pkgs }:

# NONO_PROFILE=<profile> agent <claude arguments>

pkgs.writeShellApplication {
  name = "agent";
  runtimeInputs = with pkgs; [
    unstable.claude-code
    unstable.nono
  ];
  text = ''
    # https://github.com/nolabs-ai/nono/issues/2107
    HERDR_AGENT=claude sh -c 'nono run -- claude "$@"; exit $?' sh "$@"
  '';
}
