pull_repo() {
  local repo_path="$1"
  local repo="$2"

  if [[ -d "$repo_path/.git" ]]; then
    say "pull" "$repo"
    (cd "$repo_path" && git pull)
  else
    say "pull" "skipping $repo (not a git repo)"
  fi
}
