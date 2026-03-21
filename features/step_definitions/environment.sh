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

@Then the file '{path}' should exist
  path=$(expand_path "$path")
  [[ -f "$path" ]] || fail "expected file to exist: $path"

@Then the file '{path}' should include '{text}'
  path=$(expand_path "$path")
  [[ -f "$path" ]] || fail "expected file to exist: $path"
  content=$(<"$path")
  [[ "$content" == *"$text"* ]] || fail "expected $path to include: $text"

@Then the rush config file should exist
  [[ -f "$RUSH_CONFIG" ]] || fail "expected rush config file to exist: $RUSH_CONFIG"

@Then the rush config file should include '{text}'
  [[ -f "$RUSH_CONFIG" ]] || fail "expected rush config file to exist: $RUSH_CONFIG"
  content=$(<"$RUSH_CONFIG")
  [[ "$content" == *"$text"* ]] || fail "expected $RUSH_CONFIG to include: $text"
