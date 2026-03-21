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

sample_repo_fixture_root() {
  local support_dir
  support_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
  printf '%s/sample-repo\n' "$(cd "$support_dir/.." && pwd)"
}

stub_fixture_root() {
  local support_dir
  support_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
  printf '%s/fixtures/bin\n' "$support_dir"
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
  local fixture_root
  fixture_root=$(sample_repo_fixture_root)

  prepare_isolated_environment
  cp -R "$fixture_root" "$RUSH_ROOT/sample-repo"
  echo "default = $RUSH_ROOT/sample-repo" >"$RUSH_CONFIG"
}

copy_sample_repo_fixture() {
  local path="$1"
  local fixture_root
  fixture_root=$(sample_repo_fixture_root)

  mkdir -p "$(dirname "$path")"
  cp -R "$fixture_root" "$path"
}

install_stubbed_command() {
  local command="$1"
  local fixture_root
  local stub_root
  local stub_path

  fixture_root=$(stub_fixture_root)
  stub_root=$(mktemp -d)
  stub_path="$stub_root/$command"

  [[ -f "$fixture_root/$command" ]] || fail "missing stub fixture: $fixture_root/$command"
  cp "$fixture_root/$command" "$stub_path"
  chmod +x "$stub_path"
  export PATH="$stub_root:$PATH"
  defer rm -rf "$stub_root"
}
