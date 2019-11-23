# Collect variables
repo=${args[repo]:-default}
package=${args[package]}
repo_path=$(config_get "$repo")
package_path=$repo_path/$package
script=$package_path/main

# Verify we have everything we need
[[ $repo_path ]] || abort "repo not found: $repo"
[[ -d $package_path ]] || abort "package not found: $repo/$package"
[[ -f $script ]] || abort "script not found: $script"

# Run the script (make it executable if it isnt first)
export REPO="$repo"
echo "run $(green "$repo:$package")"
[[ -x "$script" ]] || chmod u+x "$script"
cd "$package_path"
./main
