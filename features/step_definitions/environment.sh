@Given I am in an isolated environment
  prepare_isolated_environment

@Given rush is properly configured
  prepare_configured_rush_environment

@Given the directory '{path}' exists
  path=$(expand_path "$path")
  mkdir -p "$path"

@Given the environment variable '{name}' is set to '{value}'
  export "$name=$value"
  defer unset "$name"

@Given the file '{path}' contains
  path=$(expand_path "$path")
  mkdir -p "$(dirname "$path")"
  printf '%s' "$DOC_STRING" >"$path"

@Given the rush config file contains
  mkdir -p "$(dirname "$RUSH_CONFIG")"
  content=${DOC_STRING//~\//$HOME/}
  printf '%s' "$content" >"$RUSH_CONFIG"

@Given the repository '{name}' is configured at '{path}'
  path=$(expand_path "$path")
  mkdir -p "$(dirname "$RUSH_CONFIG")"
  printf '%s = %s\n' "$name" "$path" >>"$RUSH_CONFIG"

@Given the sample repository is available at '{path}'
  path=$(expand_path "$path")
  copy_sample_repo_fixture "$path"

@Given git clone populates the cloned repository with the sample fixture
  export STUB_GIT_CLONE_SOURCE="$(sample_repo_fixture_root)"
  defer unset STUB_GIT_CLONE_SOURCE

@Then the file '{path}' should exist
  path=$(expand_path "$path")
  [[ -f "$path" ]] || fail "expected file to exist: $path"

@Then the file '{path}' should not exist
  path=$(expand_path "$path")
  [[ ! -f "$path" ]] || fail "expected file to not exist: $path"

@Then the directory '{path}' should exist
  path=$(expand_path "$path")
  [[ -d "$path" ]] || fail "expected directory to exist: $path"

@Then the directory '{path}' should not exist
  path=$(expand_path "$path")
  [[ ! -d "$path" ]] || fail "expected directory to not exist: $path"

@Then the temporary directory should not contain entries matching '{pattern}'
  shopt -s nullglob
  matches=("$TMPDIR"/$pattern)
  shopt -u nullglob
  [[ ${#matches[@]} == 0 ]] || fail "expected $TMPDIR to not contain entries matching: $pattern"

@Then the file '{path}' should include '{text}'
  path=$(expand_path "$path")
  [[ -f "$path" ]] || fail "expected file to exist: $path"
  content=$(<"$path")
  [[ "$content" == *"$text"* ]] || fail "expected $path to include: $text"

@Then the file '{path}' should not include '{text}'
  path=$(expand_path "$path")
  [[ -f "$path" ]] || return 0
  content=$(<"$path")
  [[ "$content" != *"$text"* ]] || fail "expected $path to not include: $text"

@Then the file '{path}' should match '{pattern}'
  path=$(expand_path "$path")
  [[ -f "$path" ]] || fail "expected file to exist: $path"
  content=$(<"$path")
  [[ "$content" =~ $pattern ]] || fail "expected $path to match regex: $pattern"

@Then the rush config file should exist
  [[ -f "$RUSH_CONFIG" ]] || fail "expected rush config file to exist: $RUSH_CONFIG"

@Then the rush config file should include '{text}'
  [[ -f "$RUSH_CONFIG" ]] || fail "expected rush config file to exist: $RUSH_CONFIG"
  content=$(<"$RUSH_CONFIG")
  [[ "$content" == *"$text"* ]] || fail "expected $RUSH_CONFIG to include: $text"

@Then the rush config file should not include '{text}'
  [[ -f "$RUSH_CONFIG" ]] || return 0
  content=$(<"$RUSH_CONFIG")
  [[ "$content" != *"$text"* ]] || fail "expected $RUSH_CONFIG to not include: $text"

@Then the rush config file should match '{pattern}'
  [[ -f "$RUSH_CONFIG" ]] || fail "expected rush config file to exist: $RUSH_CONFIG"
  content=$(<"$RUSH_CONFIG")
  [[ "$content" =~ $pattern ]] || fail "expected $RUSH_CONFIG to match regex: $pattern"
