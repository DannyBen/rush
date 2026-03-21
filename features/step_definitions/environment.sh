@Given I am in an isolated environment
  prepare_isolated_environment

@Given rush is properly configured
  prepare_configured_rush_environment

@Given the directory '{path}' exists
  path=$(expand_path "$path")
  mkdir -p "$path"

@Given git clone is stubbed
  stub_git_clone

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

@Then the file '{path}' should exist
  path=$(expand_path "$path")
  [[ -f "$path" ]] || fail "expected file to exist: $path"

@Then the directory '{path}' should exist
  path=$(expand_path "$path")
  [[ -d "$path" ]] || fail "expected directory to exist: $path"

@Then the directory '{path}' should not exist
  path=$(expand_path "$path")
  [[ ! -d "$path" ]] || fail "expected directory to not exist: $path"

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
