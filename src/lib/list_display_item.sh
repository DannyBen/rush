list_display_item() {
  local package="$1"
  local infofile="$2"
  local repo="$3"
  local simple="$4"
  local width

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
