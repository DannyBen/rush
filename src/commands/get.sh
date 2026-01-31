## Collect variables
package=${args[package]}
repo="default"
clone=${args[--clone]}
[[ -n "${args['--force']}" ]] && export FORCE=1
[[ -n "${args['--verbose']}" ]] && export VERBOSE=1

if [[ $package =~ (.*):(.*) ]]; then
  repo=${BASH_REMATCH[1]}
  package=${BASH_REMATCH[2]}
fi

if ! config_has_key "$repo" && [[ $clone ]] && [[ $repo != 'default' ]]; then
  say "get" "repo $repo does not exist, attempting clone"
  rush clone "$repo"
fi

repo_path=$(config_get "$repo")
package_path=$repo_path/$package
script=$package_path/main

## Verify we have everything we need
[[ $repo_path ]] || abort "repo not found: $repo"
[[ -d $package_path ]] || abort "package not found: $repo:$package"
[[ -f $script ]] || abort "script not found: $script"

## Run the script (make it executable if it isn't first)
export REPO="$repo"
export REPO_PATH="$repo_path"
[[ -z "$USER_CWD" ]] && export USER_CWD="$PWD"

if [[ $repo == "default" ]]; then
  package_name="$package"
else
  package_name="$repo:$package"
fi

say "get" "$package_name"
[[ -x "$script" ]] || chmod u+x "$script"
cd "$package_path"

finish() {
  exitcode="$?"
  [[ $exitcode == 0 ]] || warn "get" "$package_name exited with error ($exitcode)"
}

trap finish EXIT

./main
