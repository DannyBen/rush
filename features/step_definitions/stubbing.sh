@Given the command '{command}' is stubbed
  install_stubbed_command "$command"

@Given my fzf selection will be '{selection}'
  export STUB_FZF_INPUT="$TMPDIR/fzf-input"
  export STUB_FZF_SELECTION="$selection"
  defer unset STUB_FZF_INPUT
  defer unset STUB_FZF_SELECTION

@Then the fzf menu should show
  [[ -f "$STUB_FZF_INPUT" ]] || fail "fzf input was not captured"

  actual=$(fzf_menu_display "$STUB_FZF_INPUT")

  [[ "$actual" == "$DOC_STRING" ]] || fail "expected fzf menu to show:\n$DOC_STRING\n\ngot:\n$actual"
