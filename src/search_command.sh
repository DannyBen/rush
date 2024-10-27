search_repo() {
  repo="$1"
  text="$2"
  set +e

  repo_path=$(config_get "$repo")

  ## Add "repo:" to the result unless it is the default
  prefix=''
  [[ "$repo" != "default" ]] && prefix="$repo:"

  ## Search directories matching search text
  bold "Matching packages ($repo):\n"
  find "$repo_path" -type f -name main |
    sed "s#${repo_path}/#${prefix}#g; s#/main##" |
    grep --color=always --ignore-case "$text" |
    sort

  ## Search info files matching search text
  bold "\nMatching info files ($repo):\n"
  grep --color=always --initial-tab --recursive --ignore-case --include "info" \
    "$text" "$repo_path" |
    sed "s#${repo_path}/#${prefix}#g; s#/info##" |
    sort

  echo
}

if is_busybox_grep; then
  abort "cannot run with BusyBox grep.\nplease install GNU grep:\napk add --no-cache grep"
fi

text=${args[text]}

for k in $(config_keys); do
  search_repo "$k" "$text"
done

