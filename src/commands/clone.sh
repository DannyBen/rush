## Collect variables
path=${args[path]}
repo_id=${args[github_user]}
use_ssh=${args[--ssh]}
shallow=${args[--shallow]}
ignore=${args[--ignore]}
default_repo_name=${repo_id%%/*}
default=${args[--default]}

if [[ $default ]]; then
  repo_name=default
else
  repo_name=${args[--name]:-$default_repo_name}
fi

## Adjust repo_id - defaults to $user/rush-repo
[[ $repo_id = */* ]] || repo_id="$repo_id/rush-repo"

## Set clone URL - ssh or https?
if [[ $use_ssh ]]; then
  repo_url=git@github.com:$repo_id.git
else
  repo_url=https://github.com/$repo_id.git
fi

## Set default path if not provided
[[ $path ]] || path="$RUSH_ROOT/$repo_id"

## Abort if target directory exists
if [[ -d $path ]]; then
  if [[ $ignore ]]; then
    skip=1
  else
    abort "directory $path already exists."
  fi
fi

## Abort if a repository with this name already exists
if config_has_key "$repo_name"; then
  if [[ $ignore ]]; then
    skip=1
  else
    abort "the repository is already registered:\n$repo_name = $(config_get "$repo_name")."
  fi
fi

if [[ $skip ]]; then
  say "clone" "skipping $repo_name (exists)"

else
  ## Clone
  say "clone" "$repo_url"

  if [[ $shallow ]]; then
    git clone --depth 1 "$repo_url" "$path"
  else
    git clone "$repo_url" "$path"
  fi

  ## Save config
  config_set "$repo_name" "$path"

fi
