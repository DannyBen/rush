list_display_item() {
  package="$1"
  infofile="$2"
  repo="$3"
  simple=${args[--simple]}
  width=$((${COLUMNS:-80} + 9))

  [[ "$repo" != "default" ]] && package="$repo:$package"
  if [[ $simple ]]; then
    printf "%s\n" "$package"
  else
    info=$(head -1 "$infofile" 2>/dev/null)
    padded_package=$(printf "%-20s" "$package")
    message="$(green "$padded_package")  $info"
    printf "%.${width}s\n" "$message"
  fi
}

list_show_repo() {
  local repo_or_package="$1"
  local search="${args[--search]}"
  local simple=${args[--simple]}
  local all=${args[--all]}
  local repo="$repo_or_package"
  local package glob repo_path infofile regex package_name

  if [[ $repo_or_package =~ (.*):(.*) ]]; then
    repo=${BASH_REMATCH[1]}
    package=${BASH_REMATCH[2]}
  fi

  repo_path=$(config_get "$repo")

  if [[ ! $repo_path ]]; then
    package="$repo"
    repo="default"
    repo_path=$(config_get "$repo")
  fi

  if [[ $package ]]; then
    glob=("$repo_path"/"$package"/**/info)
  else
    if [[ $all ]]; then
      glob_files=$(find "$repo_path" -type f -name 'info' | sort)
    else
      glob_files=$(find "$repo_path" -maxdepth 2 -type f -name 'info' | sort)
    fi
    readarray -t glob < <(echo "${glob_files[@]}")
  fi

  if [[ ${glob[0]} =~ .*\*.* ]]; then
    infofile="$repo_path/$package/info"
    if [[ -f "$infofile" ]]; then
      list_display_item "$package" "$infofile" "$repo"
    elif [[ ! $simple ]]; then
      red "nothing in $repo repo"
    fi
  
  else
    for infofile in "${glob[@]}"; do
      if [[ $search ]]; then
        regex="$repo_path/(.*${search}.*)/info"
      else
        regex="$repo_path/(.*)/info"
      fi

      if [[ $infofile =~ $regex ]]; then
        package_name="${BASH_REMATCH[1]}"
        list_display_item "$package_name" "$infofile" "$repo"
      fi
    done
  fi
}

repo_or_package=${args[repo_or_package]}

if [[ $repo_or_package ]]; then
  list_show_repo "$repo_or_package"
else
  for k in $(config_keys); do
    list_show_repo "$k"
  done
fi
