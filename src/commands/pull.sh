repo=${args[repo]}

if [[ $repo ]]; then
  repo_path=$(config_get "$repo")
  [[ $repo_path ]] || abort "no such repo: $repo"
  pull_repo "$repo_path" "$repo"
else
  for k in $(config_keys); do
    pull_repo "$(config_get "$k")" "$k"
  done
fi

