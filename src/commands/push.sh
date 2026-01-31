set +e
all=${args[--all]}
repo=${args[repo]:-default}
message=${args[--message]:-"automatic commit"}

push_repo() {
  local repo_path="$1"
  local repo="$2"

  if [[ -d "$repo_path/.git" ]]; then
    say "push" "$repo"
    (
      set -e
      cd "$repo_path"
      
      say "push" "$repo: adding files"
      git add . --all
      
      if [[ -n "${args[--chmod]}" ]]; then
        say "push" "$repo: applying chmod +x"
        git ls-files | grep -E "undo|main" | xargs -I {} git update-index --chmod +x {}
      fi
      say "push" "$repo: committing"
      git commit -am "$message"
      
      say "push" "$repo: pushing"
      git push
    )
  else
    say "push" "$repo: skipping (not a git repo)"
  fi
}

if [[ $all ]]; then
  for k in $(config_keys); do
    push_repo "$(config_get "$k")" "$k"
  done
else
  repo_path=$(config_get "$repo")
  [[ $repo_path ]] || abort "no such repo: $repo"
  push_repo "$repo_path" "$repo"
fi

