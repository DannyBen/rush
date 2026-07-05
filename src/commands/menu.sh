repo_or_package=${args[repo_or_package]}
install=${args[--install]}
list_args=(--all)

[[ $repo_or_package ]] && list_args+=("$repo_or_package")

items=$(NO_COLOR=1 rush list "${list_args[@]}")

if ! selected=$(printf "%s\n" "$items" | fzf --color='fg+:green:bold,bg+:-1,pointer:green:bold'); then
  exit 0
fi

[[ $selected ]] || exit 0

package=${selected%%[[:space:]]*}

[[ $package ]] || exit 0

if [[ $install ]]; then
  rush get "$package"
else
  rush info "$package"
fi
