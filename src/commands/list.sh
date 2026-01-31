repo_or_package=${args[repo_or_package]}
search=${args[--search]}
simple=${args[--simple]}
all=${args[--all]}

if [[ $repo_or_package ]]; then
  list_show_repo "$repo_or_package" "$search" "$simple" "$all"
else
  for k in $(config_keys); do
    list_show_repo "$k" "$search" "$simple" "$all"
  done
fi
