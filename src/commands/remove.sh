repo=${args[repo]}
purge=${args[--purge]}

say "remove" "$repo"

if [[ $purge ]]; then
  repo_path=$(config_get "$repo")
  if [[ -d $repo_path ]]; then
    rm -rf "$repo_path"
    say "remove" "purged $repo_path"
  fi
fi

config_del "$repo"