list_display_item() {
  package="$1"
  infofile="$2"
  repo="$3"
  simple=${args[--simple]}

  [[ "$repo" != "default" ]] && package="$repo:$package"
  if [[ $simple ]]; then
    printf "%s\n" "$package"
  else
    info=$(head -1 "$infofile" 2> /dev/null)
    printf "%s\n%s\n\n" "$(green "$package")" "$info"
  fi
}

list_show_repo() {
  repo_or_package="$1"
  search="${args[--search]}"
  repo="$repo_or_package"

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
    glob=( "$repo_path"/"$package"/*/info )
  else
    glob=( "$repo_path"/*/info )
  fi

  if [[ ${glob[0]} =~ \* ]]; then
    infofile="$repo_path/$package/info"
    if [[ -f "$infofile" ]]; then
      list_display_item "$package" "$infofile" "$repo"
    else
      red "no matches"
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
