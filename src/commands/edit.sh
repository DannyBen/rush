## Collect variables
package=${args[package]}
file=${args[file]:-main}
repo="default"
edit=${EDITOR:-vi}

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
[[ -f $file_path ]] || abort "file not found: $file_path"

## Edit the file
"$edit" "$file_path"
