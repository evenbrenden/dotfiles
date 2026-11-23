{ pkgs }:

pkgs.writeShellApplication {
  name = "agent";
  runtimeInputs = [
    pkgs.unstable.claude-code
    pkgs.unstable.nono
  ];
  text = ''
    # https://github.com/nolabs-ai/nono/issues/2107
    HERDR_AGENT=claude sh -c 'nono run -- claude "$@"; exit $?' sh "$@"
  '';
}
