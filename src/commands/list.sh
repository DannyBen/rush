repo_or_package=${args[repo_or_package]}
simple=${args[--simple]}
all=${args[--all]}

if [[ $repo_or_package ]]; then
  list_show_repo "$repo_or_package" "$simple" "$all"
else
  for k in $(config_keys); do
    list_show_repo "$k" "$simple" "$all"
  done
fi
