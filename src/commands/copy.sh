source_package=${args[source_package]}
target_package=${args[target_package]}
force=${args[--force]}
source_repo=default
target_repo=default

if [[ $source_package =~ (.*):(.*) ]]; then
  source_repo=${BASH_REMATCH[1]}
  source_package=${BASH_REMATCH[2]}
fi

if [[ -z "$target_package" ]]; then
  target_package="$source_package"
elif [[ $target_package =~ (.*):(.*) ]]; then
  target_repo=${BASH_REMATCH[1]}
  target_package=${BASH_REMATCH[2]}
fi

source_repo_path=$(config_get "$source_repo")
target_repo_path=$(config_get "$target_repo")
source_package_path="$source_repo_path/$source_package"
target_package_path="$target_repo_path/$target_package"

if [[ $source_repo == "default" ]]; then
  source_display_name="$source_package"
else
  source_display_name="$source_repo:$source_package"
fi

if [[ $target_repo == "default" ]]; then
  target_display_name="$target_package"
else
  target_display_name="$target_repo:$target_package"
fi

[[ $source_repo_path ]] || abort "source repo not found: $source_repo"
[[ $target_repo_path ]] || abort "target repo not found: $target_repo"
[[ -d $source_package_path ]] || abort "source package not found: $source_repo:$source_package"
if [[ -d $target_package_path ]]; then
  if [[ $force ]]; then
    rm -rf "$target_package_path"
  else
    abort "target package already exists: $target_repo:$target_package\nrun again with --force to copy anyway"
  fi
fi

say "copy" "$source_display_name to $target_display_name"
mkdir -p "$(dirname "$target_package_path")"
cp -R "$source_package_path" "$target_package_path"
