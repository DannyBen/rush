repo=${args[repo]}
path=${args[path]}

config_set "$repo" "$path"
say "add" "$repo = $path"
