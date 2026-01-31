search_repo() {
  repo="$1"
  text="$2"
  set +e

  repo_path=$(config_get "$repo")

  ## Add "repo:" to the result unless it is the default
  prefix=''
  [[ "$repo" != "default" ]] && prefix="$repo:"

  grep_color_flag=""
  if grep --help 2>&1 | grep -q -- "--color"; then
    grep_color_flag="--color=always"
  fi

  ## Search directories matching search text
  bold "Matching packages ($repo):\n"
  find "$repo_path" -type f -name main |
    sed "s#${repo_path}/#${prefix}#g; s#/main##" |
    grep $grep_color_flag --ignore-case -- "$text" |
    sort

  ## Search info files matching search text
  bold "\nMatching info files ($repo):\n"
  find "$repo_path" -type f -name info -exec grep $grep_color_flag --ignore-case -n -- "$text" {} + |
    sed "s#${repo_path}/#${prefix}#g; s#/info##" |
    sort

  echo
}

text=${args[text]}

for k in $(config_keys); do
  search_repo "$k" "$text"
done
