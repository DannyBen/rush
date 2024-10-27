search_repo() {
  repo="$1"
  text="$2"
  set +e

  repo_path=$(config_get "$repo")

  ## Add "repo:" to the result unless it is the default
  prefix=''
  [[ "$repo" != "default" ]] && prefix="$repo:"

  ## Search directories matching search text
  blue "Matching packages:\n"
  find "$repo_path" -type d | grep -v "$repo_path.*/\." |
    grep --color=always "$text" |
    sed "s#${repo_path}/#${prefix}#g" |
    sed 's#/info##'

  ## Search info files matching search text
  blue "\nMatching info files:\n"
  grep --color=always --initial-tab --recursive --ignore-case --include "info" \
    "$text" "$repo_path" |
    sort |
    sed "s#${repo_path}/#${prefix}#g" | sed 's#/info##'

  echo
}

if is_busybox_grep; then
  abort "cannot run with BusyBox grep.\nplease install GNU grep:\napk add --no-cache grep"
fi

text=${args[text]}

for k in $(config_keys); do
  search_repo "$k" "$text"
done

