expand_path() {
  local path="$1"
  if [[ "$path" == "~" ]]; then
    printf '%s\n' "$HOME"
  elif [[ "$path" == "~/"* ]]; then
    printf '%s/%s\n' "$HOME" "${path#"~/"}"
  else
    printf '%s\n' "$path"
  fi
}

prepare_isolated_environment() {
  local old_pwd="$PWD"
  local old_home="${HOME-}"
  local old_rush_config="${RUSH_CONFIG-}"
  local old_rush_root="${RUSH_ROOT-}"
  local old_tmpdir="${TMPDIR-}"
  local isolation_root

  isolation_root=$(mktemp -d)
  defer rm -rf "$isolation_root"

  export HOME="$isolation_root/home"
  defer export HOME="$old_home"

  export RUSH_CONFIG="$HOME/rush.ini"
  defer export RUSH_CONFIG="$old_rush_config"

  export RUSH_ROOT="$HOME/rush-repos"
  defer export RUSH_ROOT="$old_rush_root"

  export TMPDIR="$isolation_root/tmp"
  defer export TMPDIR="$old_tmpdir"

  mkdir -p "$HOME" "$RUSH_ROOT" "$TMPDIR"
  cd "$HOME"
  defer cd "$old_pwd"
}

prepare_configured_rush_environment() {
  local fixture_root="$PWD/sample-repo"

  prepare_isolated_environment
  cp -R "$fixture_root" "$RUSH_ROOT/sample-repo"
  echo "default = $RUSH_ROOT/sample-repo" >"$RUSH_CONFIG"
}

stub_command() {
  local command="$1"
  local stub_root
  local stub_path

  stub_root=$(mktemp -d)
  stub_path="$stub_root/$command"

  cat >"$stub_path" <<EOF
#!/usr/bin/env bash
printf 'stubbed: %s' '$command'
if (( \$# )); then
  printf ' %s' "\$@"
fi
printf '\n'
EOF

  chmod +x "$stub_path"
  export PATH="$stub_root:$PATH"
  defer rm -rf "$stub_root"
}

stub_git_clone() {
  local stub_root
  local stub_path

  stub_root=$(mktemp -d)
  stub_path="$stub_root/git"

  cat >"$stub_path" <<'EOF'
#!/usr/bin/env bash
printf 'stubbed: git'
if (( $# )); then
  printf ' %s' "$@"
fi
printf '\n'

if [[ "$1" == "clone" ]]; then
  mkdir -p "${@: -1}"
fi
EOF

  chmod +x "$stub_path"
  export PATH="$stub_root:$PATH"
  defer rm -rf "$stub_root"
}
