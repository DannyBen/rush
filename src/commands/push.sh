set +e
all=${args[--all]}
repo=${args[repo]:-default}
message=${args[--message]:-"automatic commit"}

if [[ $all ]]; then
  for k in $(config_keys); do
    push_repo "$(config_get "$k")" "$k"
  done
else
  repo_path=$(config_get "$repo")
  [[ $repo_path ]] || abort "no such repo: $repo"
  push_repo "$repo_path" "$repo"
fi

