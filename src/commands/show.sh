## Collect variables
package=${args[package]}
file=${args[file]}
repo="default"

if [[ $package =~ (.*):(.*) ]]; then
  repo=${BASH_REMATCH[1]}
  package=${BASH_REMATCH[2]}
fi

repo_path=$(config_get "$repo")
package_path="$repo_path/$package"
file_path="$package_path/$file"

## Verify we have everything we need
[[ $repo_path ]] || abort "repo not found: $repo"
[[ -d $package_path ]] || abort "package not found: $repo:$package"

## Show the package data
if [[ $file ]]; then
  [[ -f $file_path ]] || abort "file not found: $file_path"
  cat "$file_path"
else
  shopt -s dotglob
  for f in "$package_path"/*; do
    if [[ -f "$f" ]]; then
      green "$(basename "$f")"
      cat "$f"
      echo
      echo
    fi
  done
  shopt -u dotglob
fi
