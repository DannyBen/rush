## Collect variables
repo=${args[repo]}
repo_path=$(config_get "$repo")

## Verify we have everything we need
[[ $repo_path ]] || abort "repo not found: $repo"

config_set "default" "$repo_path"
config_del "$repo"
say "default" "$repo ($repo_path)"