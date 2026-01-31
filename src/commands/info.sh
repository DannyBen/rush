## Collect variables
package=${args[package]}
repo="default"

if [[ $package =~ (.*):(.*) ]]; then
  repo=${BASH_REMATCH[1]}
  package=${BASH_REMATCH[2]}
fi

repo_path=$(config_get "$repo")
package_path="$repo_path/$package"
infofile="$package_path/info"

## Verify we have everything we need
[[ $repo_path ]] || abort "repo not found: $repo"
[[ -d $package_path ]] || abort "package not found: $repo:$package"
[[ -f $infofile ]] || abort "infofile not found: $infofile"

cat "$infofile"
