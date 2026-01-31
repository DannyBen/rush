repo_or_package=${args[repo_or_package]}

if [[ $repo_or_package ]]; then
  list_show_repo "$repo_or_package"
else
  for k in $(config_keys); do
    list_show_repo "$k"
  done
fi
