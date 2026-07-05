repo_or_package=${args[repo_or_package]}
install=${args[--install]}
list_args=(--all)

[[ $repo_or_package ]] && list_args+=("$repo_or_package")

items=$(rush list "${list_args[@]}")

if ! selected=$(printf "%s\n" "$items" | fzf --ansi); then
  exit 0
fi

[[ $selected ]] || exit 0

plain=$(printf "%s" "$selected" | sed -E $'s/\x1B\\[[0-9;]*[[:alpha:]]//g')
package=${plain%%[[:space:]]*}

[[ $package ]] || exit 0

if [[ $install ]]; then
  rush get "$package"
else
  rush info "$package"
fi
