{ pkgs, agent }:

# NONO_PROFILE=<profile> spec <name>

pkgs.writeShellApplication {
  name = "spec";
  runtimeInputs = [
    agent
    pkgs.git
  ];
  text = ''
    name="$1"

    branch="$USER/$name"
    git_common_dir="$(git rev-parse --git-common-dir)"
    repo_root="$(cd "$git_common_dir/.." && pwd)"
    worktree_dir="$repo_root/.worktrees/$name"

    cd "$repo_root"
    git worktree add "$worktree_dir" -b "$branch"

    temp_file="$(mktemp "$TMPDIR/claude-prompt-XXXXXX.md")"
    trap 'rm -f "$temp_file"' EXIT

    cd "$worktree_dir"
    $EDITOR "$temp_file"
    prompt="$(cat "$temp_file")"

    agent --name "$name" --remote-control -- "$prompt"
  '';
}
