@When I run '{command}'
  run "$command"

@Then the exit code should be '{code}'
  [[ "$LAST_EXIT_CODE" == "$code" ]] || fail "expected exit code $code, got $LAST_EXIT_CODE"

@Then the exit code should mean success
  [[ "$LAST_EXIT_CODE" == 0 ]] || fail "expected successful exit code, got $LAST_EXIT_CODE"

@Then the exit code should mean failure
  [[ "$LAST_EXIT_CODE" != 0 ]] || fail "expected failure exit code, got $LAST_EXIT_CODE"

@Then stdout should include '{text}'
  [[ "$LAST_STDOUT" == *"$text"* ]] || fail "expected stdout to include: $text"

@Then stdout should be '{text}'
  [[ "$LAST_STDOUT" == "$text" ]] || fail "expected stdout to be: $text, got: $LAST_STDOUT"

@Then stdout should be
  [[ "$LAST_STDOUT" == "$DOC_STRING" ]] || fail "expected stdout to be:\n$DOC_STRING\n\ngot:\n$LAST_STDOUT"

@Then stdout should match '{pattern}'
  [[ "$LAST_STDOUT" =~ $pattern ]] || fail "expected stdout to match regex: $pattern"

@Then stderr should include '{text}'
  [[ "$LAST_STDERR" == *"$text"* ]] || fail "expected stderr to include: $text"

@Then stderr should match '{pattern}'
  [[ "$LAST_STDERR" =~ $pattern ]] || fail "expected stderr to match regex: $pattern"
