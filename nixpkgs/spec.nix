{ pkgs }:

# NONO_PROFILE=<nono profile> spec <worktree name>

pkgs.writeShellApplication {
  name = "spec";
  # Use claude-code and nono from environment.
  runtimeInputs = [
    pkgs.git
  ];
  text = ''
    worktree_name="$1"

    branch_name="$USER/$worktree_name"
    common_git="$(git rev-parse --git-common-dir)"
    repo_root="$(cd "$common_git/.." && pwd)"
    worktree_dir="$repo_root/.worktrees/$worktree_name"

    cd "$repo_root"
    git worktree add "$worktree_dir" -b "$branch_name"

    tempfile="$(mktemp "$TMPDIR/claude-prompt-XXXXXX.md")"
    trap 'rm -f "$tempfile"' EXIT

    cd "$worktree_dir"
    $EDITOR "$tempfile"
    prompt="$(cat "$tempfile")"
    nono run -- claude --name "$worktree_name" --remote-control -- "$prompt"
  '';
}
