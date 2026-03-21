Feature: completions
  Generate bash completions

Scenario: Show --help
  When I run 'rush completions --help'
  Then the exit code should mean success
  And stdout should include 'Generate bash completions'
  And stdout should include 'rush completions'

Scenario: Generate the completions script
  Given rush is properly configured
  When I run 'rush completions'
  Then the exit code should mean success
  And stdout should include '# rush completion'
  And stdout should include '_rush_completions()'
  And stdout should include 'complete -F _rush_completions rush'
